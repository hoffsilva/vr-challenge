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
        let qty = quantity ?? 
        Service.shared.fetch(Game.self, requestLink: .getGame, parameters: nil) { (response) in
            
        }
    }
    
}
