//
//  Session.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire

class Session {
    
    // MARK: - Properties -
    
    static let shared = Session()
    
    private var manager: SessionManager?
    
    // MARK: - Methods -
    
    func apiManager() -> SessionManager {
        if let manager = manager {
            return manager
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 30
            
            let serverTrustPolicy : [String: ServerTrustPolicy] = [
                "\(EnvironmentLinks.shared)" : .disableEvaluation
            ]
            
            self.manager = SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicy))
            
            return self.manager!
        }
        
    }
    
    
    
}
