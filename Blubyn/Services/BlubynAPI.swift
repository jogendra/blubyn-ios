//
//  BlubynAPI.swift
//  Blubyn
//
//  Created by JOGENDRA on 13/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import Foundation
import Alamofire

//Note: Change before deploying app to App Store
fileprivate var testing: Bool = true

public var apiURL = testing ? BlubynURLs.testingApiURL : BlubynURLs.productionApiURL

// MARK: - Endpoints

fileprivate enum BlubynEndpoints: String {
    
    case api = "api/"
    case sendMessage = "sendmessage/"
}

// MARK: API status

enum BlubynAPIStatus: Int {
    case SUCCESS          =                 200
    
    case NO_CONTENT_FOUND  =                204
    
    case FALIURE            =               422
    
    case INTERNAL_SERVER_ERROR =            500
    
    case ERR_APP_HTTP_ERROR =               12000
    
    case ERR_APP_HTTP_RESPONSE =            12001
    
    case UNKOWN_ERROR         =             1000
}

class BlubynAPI {
    
    class func sendMessage(params: Dictionary<String, Any>, completion: @escaping(_ parsedJSON: JSON?, _ statusCode: Int?, _ error: Error?) -> Void) {
        
        guard Reachability.isConnectedToNetwork() == true else {
            ActivityIndicator.shared.hideProgressView()
            BlubynViews.noInternetConnectionAlertView()
            return
        }
        
        Network.shared.post(apiURL + BlubynEndpoints.api.rawValue + BlubynEndpoints.sendMessage.rawValue, params: params, withHeader: true, completion: { (parsedJSON, statusCode, error) in
            
            if error != nil {
                completion(nil, statusCode, error)
            } else {
                completion(parsedJSON, statusCode, error)
            }

        })
        
    }
}
