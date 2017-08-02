//
//  Service.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias HandlerObject = (Any?) -> Swift.Void

class Service {
    
    // MARK: - Files Name -
    
    private struct FileName {
        static let requestLink = "RequestLinks"
        static let environmentLink = "EnvironmentLinks"
    }
    
    // MARK: - Properties -
    
    static let shared = Service()
    
    
    
     
     func fetch(requestLink: RequestLinks, parameters: [String: Any]?, handlerObject: @escaping HandlerObject) {
     
     var url = self.requestLink(type: requestLink)
     if let parameters = parameters {
     url = self.linkWithParameters(link: url, parameters: parameters)
     }
     
     
     if !verifyConnection() {
     let error = ReachabilityError.notConnection
     handlerObject(error)
     return
     }
     
     Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
     switch dataResponse.result {
     case .success:
     guard let array = dataResponse.result.value as? [Any] else {
     handlerObject(dataResponse.data)
     return
     }
     
     var arrayObject = [Any]()
     for object in array {
     arrayObject.append(json: JSON(object))
     }
     
     handlerObject(arrayObject)
     
     case .failure:
     handlerObject(ReachabilityError.requestTimeout)
     }
     }
     }
     
     
     
    
    // MARK: - Verifications -
    
    static func verifyResult(_ object : Any?) -> (code: Int?, description: String)? {
        if let error = object as? ReachabilityError {
            return (code: nil, description: error.descriptionError())
        }
        if let error = object as? Error {
            return (code: nil, description: error.localizedDescription)
        }
        guard let responseData = (object as? ResponseData), let message = responseData.message else {
            return nil
        }
        
        return (code: nil, description: message )
    }
    
    private func verifyConnection() -> Bool{
        
        if let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: "www.google.com") {
            
            if reachabilityNetwork.isReachable {
                return true
            }
        }
        return false
        
    }
    
    // MARK: - File Managers - Link requests -
    
    private func requestLink(type: RequestLinks) -> String {
        var link = ""
        
        if let host = EnvironmentLinks.shared.current {
            link.append(keyManagerFile(key:host))
            link.append(keyManagerFile(key:type))
        }
        
        return link
    }
    
    private func keyManagerFile(key:Any) -> String{
        
        if  let key = key as? EnvironmentBase{
            let file = FileManager.load(name: FileName.environmentLink)
            if let host = file?.object(forKey: key.rawValue) as? String {
                return host
            }
            
        }
        if  let key = key as? RequestLinks{
            let file = FileManager.load(name: FileName.requestLink)
            if let link = file?.object(forKey: key.rawValue) as? String {
                return link
            }
        }
        return ""
    }
    
    private func linkWithParameters(link: String, parameters: [String: Any]) -> String {
        var newLink = link
        for parameter in parameters {
            newLink = newLink.replacingOccurrences(of: "<\(parameter.key)>", with: "\(parameter.value)")
        }
        return newLink
    }
}

// MARK: - Reachability Custom Error -

enum ReachabilityError : Error {
    case notConnection
    case requestTimeout
    
    func descriptionError() -> String {
        switch self {
        case .notConnection:
            return "CONNECTION_VERIFY"
        case .requestTimeout:
            return "REQUEST_TIMEOUT"
        }
    }
}
