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

enum BlubynEndpoints: String {
    
    case api = "api/"
    case sendMessage = "sendmessage/"
}

class BlubynAPI {
    
}
