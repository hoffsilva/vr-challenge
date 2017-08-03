//
//  GameRealmModel.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 02/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import RealmSwift

class GameRealmModel: Object {

    
    //MARK: - Init -
    convenience init(id: Int) {
        self.init()
        self.id = id 
    }
    
    //MARK: - Persisted Properties
    dynamic var name = ""
    dynamic var popularity = 0
    dynamic var id = 0
    dynamic var giantbombId = 0
    dynamic var localizedName = ""
    dynamic var locale = ""
    dynamic var coverURL = ""
    dynamic var viewers = 0
    dynamic var channels = 0
    dynamic var isFavorite = false
    
    //MARK: - Meta - 
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    
}
