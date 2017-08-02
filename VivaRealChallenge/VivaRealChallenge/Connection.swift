//
//  Connection.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire

typealias handlerRensponseJSON = (Alamofire.DataResponse<Any>) -> Swift.Void

class Connection  {
    
    // MARK: - Properties -
    
    static let shared = Connection()
    
    var headers : HTTPHeaders?
    
    // MARK: - Methods -
    
    static func request(_ url: String, method: HTTPMethod, parameters: [String: Any]?, dataResponseJSON: @escaping handlerRensponseJSON) {
        
        let manager = Session.shared.apiManager()
        setHeaders()
        manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: Connection.shared.headers).responseJSON { (response) in
            dataResponseJSON(response)
        }
    }
    
    static func requestWithOutHeader(_ url: String, method: HTTPMethod, parameters: [String: Any]?, dataResponseJSON: @escaping handlerRensponseJSON) {
        
        let manager = Session.shared.apiManager()
        manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            dataResponseJSON(response)
        }
    }
    
    static func setHeaders() {
        let headers = [
            "Accept": "application/vnd.twitchtv.v5+json",
            "Client-ID" : "9uzthbq3e4iglncryagtk2u32pxai3"
        ]
        Connection.shared.headers = headers
    }
}
