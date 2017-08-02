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
        Service.shared.fetch(Game.self, requestLink: .getGame, parameters: ["quantity" : qty]) { (response) in
            //sprint(response)
            if let error = Service.verifyResult(response) {
                self.delegate?.showError(message: error.description)
                return
            }
            for game in (response as? [Game])!{
                self.arrayOfGames.append(game)
            }
            self.delegate?.loadGameSuccesfuly()
        }
    }
    
}
