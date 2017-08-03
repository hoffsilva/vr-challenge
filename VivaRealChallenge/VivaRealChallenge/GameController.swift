//
//  GameController.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritedGameDelegate: class {
    func favoritedGamesLoadedSuccessfuly()
    func deletedSuccessfuly()
}

protocol GameFavoriteDelegate: class {
    func gameIsFavorite(answer: Bool)
}

protocol GameDelegate: class {
    func loadGameSuccesfuly()
    func showError(message: String)
}

class GameController {
    
    weak var delegate: GameDelegate?
    weak var favoriteDelegate: GameFavoriteDelegate?
    weak var favoritedGameDelegate: FavoritedGameDelegate?
    
    var arrayOfBackgrounds = [#imageLiteral(resourceName: "ac.jpg"),#imageLiteral(resourceName: "ac2.jpg"),#imageLiteral(resourceName: "ac3.jpg"),#imageLiteral(resourceName: "battlefield.jpg"),#imageLiteral(resourceName: "bs.jpg"),#imageLiteral(resourceName: "cs.jpg"),#imageLiteral(resourceName: "ds.jpg"),#imageLiteral(resourceName: "fc.jpg"),#imageLiteral(resourceName: "gta.jpg"),#imageLiteral(resourceName: "halo.jpg"),#imageLiteral(resourceName: "halo1.jpg"),#imageLiteral(resourceName: "halob.jpg"),#imageLiteral(resourceName: "hitman.jpg"),#imageLiteral(resourceName: "metro.jpg"),#imageLiteral(resourceName: "mine.jpg"),#imageLiteral(resourceName: "mk.jpg"),#imageLiteral(resourceName: "tb.jpg"),#imageLiteral(resourceName: "tf.jpg"),#imageLiteral(resourceName: "tf2.jpg"),#imageLiteral(resourceName: "tf3.jpg"),#imageLiteral(resourceName: "ts.jpg"),#imageLiteral(resourceName: "wd.jpg")]
    
    var arrayOfGames = [GameRealmModel]()
    
    var arrayOfFavoritedGames = [GameRealmModel]()
    
    func getGames(quantity: Int?) {
        let qty = quantity ?? 50
        Service.shared.fetch(requestLink: .getGame, parameters: ["quantity" : qty]) { (response) in
            if let error = Service.verifyResult(response) {
                self.delegate?.showError(message: error.description)
                return
            }
            let parsedResponse = (try! JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            
            guard let topGames = parsedResponse.value(forKey: "top") as?  [[String : Any]] else {
                self.delegate?.showError(message: "Não foi possível carregar os dados...")
                return
            }
            for game in topGames {
                let psdGame = game["game"] as! [String : Any]
                let gm = Game()
                gm.channels = game["channels"] as? Int
                gm.viewers = game["viewers"] as? Int
                gm.giantbombId = psdGame["giantbomb_id"] as? Int
                gm.id = psdGame["_id"] as? Int
                gm.locale = psdGame["locale"] as? String
                gm.popularity = psdGame["popularity"] as? Int
                gm.name = psdGame["name"] as? String
                gm.localizedName = psdGame["localized_name"] as? String
                let box = psdGame["box"] as! [String : Any]
                gm.coverURL = box["large"] as? String
                
                let realmGame = GameRealmModel()
                realmGame.channels = gm.channels!
                realmGame.coverURL = gm.coverURL!
                realmGame.giantbombId = gm.giantbombId!
                realmGame.id = gm.id!
                realmGame.isFavorite = false
                realmGame.locale = gm.locale!
                realmGame.localizedName = gm.localizedName!
                realmGame.name = gm.name!
                realmGame.popularity = gm.popularity!
                realmGame.viewers = gm.viewers!
                
                self.saveGameOnRealm(game: realmGame)
            }
            self.getGamesFromRealm()
            self.delegate?.loadGameSuccesfuly()
        }
    }
    
    func saveGameOnRealm(game: GameRealmModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(GameRealmModel.self, value: ["id" : game.id, "channels" : game.channels, "coverURL" : game.coverURL, "giantbombId" : game.giantbombId, "locale" : game.locale, "localizedName" : game.localizedName, "name" : game.name, "popularity" : game.popularity, "viewers": game.viewers], update: true)
        }
    }
    
    func getGamesFromRealm() {
        let realm = try! Realm()
        let games = realm.objects(GameRealmModel.self)
        for game in games {
            arrayOfGames.append(game)
        }
    }
    
    func getFavoritedGames() {
        arrayOfFavoritedGames.removeAll()
        let realm = try! Realm()
        let p1 = NSPredicate(format: "isFavorite == true")
        let favoritedGames = realm.objects(GameRealmModel.self)
        .filter(p1)
        for favoritedGame in favoritedGames {
            arrayOfFavoritedGames.append(favoritedGame)
        }
        self.favoritedGameDelegate?.favoritedGamesLoadedSuccessfuly()
        
    }
    
    func addToFavoriteList(game: GameRealmModel) {
        let realm = try! Realm()
        try! realm.write {
            game.isFavorite = true
            GameSingleton.shared.game = realm.create(GameRealmModel.self, value: ["id" : game.id, "channels" : game.channels, "coverURL" : game.coverURL, "giantbombId" : game.giantbombId, "locale" : game.locale, "localizedName" : game.localizedName, "name" : game.name, "popularity" : game.popularity, "viewers": game.viewers, "isFavorite" : game.isFavorite], update: true)
            self.favoriteDelegate?.gameIsFavorite(answer: true)
        }
    }
    
    func removeFromFavoriteList(game: GameRealmModel) {
        let realm = try! Realm()
        try! realm.write {
           game.isFavorite = false
           realm.create(GameRealmModel.self, value: ["id" : game.id, "channels" : game.channels, "coverURL" : game.coverURL, "giantbombId" : game.giantbombId, "locale" : game.locale, "localizedName" : game.localizedName, "name" : game.name, "popularity" : game.popularity, "viewers": game.viewers, "isFavorite" : game.isFavorite], update: true)
            self.favoriteDelegate?.gameIsFavorite(answer: false)
        }
        arrayOfFavoritedGames.removeAll()
        getFavoritedGames()
    }
    
    func detailGame(rowOfGame: Int) {
        GameSingleton.shared.game = getGame(rowOfGame: rowOfGame)
    }
    
    func getGame(rowOfGame: Int) -> GameRealmModel {
        return arrayOfGames[rowOfGame]
    }
    
    func getURL(item: Int) -> String {
        return getGame(rowOfGame: item).coverURL
    }
    
    func isFavorite(item: Int) -> Bool {
        return getGame(rowOfGame: item).isFavorite
    }
    
    func getFavoritedGame(rowOfGame: Int) -> GameRealmModel {
        return arrayOfFavoritedGames[rowOfGame]
    }
    
    func getFavoritedURL(item: Int) -> String {
        return getFavoritedGame(rowOfGame: item).coverURL
    }
    
    func getFavoritedName(item: Int) -> String {
        return getFavoritedGame(rowOfGame: item).name
    }
    
    func getFavoritedPopularity(item: Int) -> Int {
        return getFavoritedGame(rowOfGame: item).popularity
    }
    
    func deleteFavoritedGame(item: Int) {
        let realm = try! Realm()
        try! realm.write {
            let game = getFavoritedGame(rowOfGame: item)
            GameSingleton.shared.game = realm.create(GameRealmModel.self, value: ["id" : game.id, "channels" : game.channels, "coverURL" : game.coverURL, "giantbombId" : game.giantbombId, "locale" : game.locale, "localizedName" : game.localizedName, "name" : game.name, "popularity" : game.popularity, "viewers": game.viewers, "isFavorite" : false], update: true)
            self.favoritedGameDelegate?.deletedSuccessfuly()
        }
        arrayOfFavoritedGames.remove(at: item)
    }
    
    func getBackground(item: Int) -> UIImage {
        return arrayOfBackgrounds[item]
    }
    
}
