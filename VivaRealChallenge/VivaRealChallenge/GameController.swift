//
//  GameController.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func loadGameSuccesfuly()
    func showError(message: String)
}

class GameController {
    
    weak var delegate: GameDelegate?
    
    var arrayOfGames = [Game]()
    
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
                self.arrayOfGames.append(gm)
            }
            self.delegate?.loadGameSuccesfuly()
        }
    }
    
    func detailGame(rowOfGame: Int) {
        GameSingleton.shared.game = getGame(rowOfGame: rowOfGame)
    }
    
    func getGame(rowOfGame: Int) -> Game {
        return arrayOfGames[rowOfGame]
    }
    
    func getURL(item: Int) -> String {
        return getGame(rowOfGame: item).coverURL ?? ""
    }
    
}
