//
//  BlubynUserDefaultsService.swift
//  Blubyn
//
//  Created by JOGENDRA on 11/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import Foundation

public class BlubynUserDefaultsService {
    
    class func set(login: Bool) {
        UserDefaults.standard.set(login, forKey: BlubynKeys.isUserLoggedIn)
    }
}
