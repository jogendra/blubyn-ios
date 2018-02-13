//
//  BlubynAPI.swift
//  Blubyn
//
//  Created by JOGENDRA on 13/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import Foundation
import Alamofire

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
    
}
