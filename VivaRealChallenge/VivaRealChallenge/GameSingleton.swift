//
//  GameSingleton.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 02/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class GameSingleton: NSObject {
    
    static let shared = GameSingleton()
    
    var game = Game()
    
    func clearData() {
        GameSingleton.shared.game = Game()
    }
    
}
