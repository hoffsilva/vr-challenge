//
//  EnvironmentLinks.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

// MARK: - Enviroment Links Singleton -

class EnvironmentLinks {
    
    // MARK: - Properties -
    
    static let shared = EnvironmentLinks()
    
    var current : EnvironmentBase?
    
}

// MARK: - Environment Base Enum -

enum EnvironmentBase: String {
    
    case twitch
    
}

// MARK: - Request Link Enum -

enum RequestLinks: String {
    
    case getGame
}
