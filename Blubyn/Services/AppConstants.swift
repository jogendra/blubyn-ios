//
//  AppConstants.swift
//  Blubyn
//
//  Created by JOGENDRA on 10/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import Foundation

// MARK: - Images names

struct BlubynImages {
    
    static let profileIcon: String = "profile-icon"
    static let myTripIcon: String = "mytrip-icon"
    static let experiencesIcon: String = "eye-icon"
    static let shareIcon: String = "share-icon"
    static let helpAndFeedbackIcon: String = "help-and-feedback"
    static let settingsIcon: String = "settings-icon"
    static let likeOnFacebookIcon: String = "like-us-on-facebook"
    static let rateUsIcon: String = "rate-us"
    static let logoutIcon: String = "logout-icon"
}

// MARK: - Keys

struct BlubynKeys {
    
    static let isUserLoggedIn: String = "isUserLoggedIn"
}

// MARK: - Endpoints

enum BlubynEndpoints: String {
    
    case api = "api/"
    case sendMessage = "sendmessage/"
}

// MARK: - API URLs

struct BlubynURLs {
    
    static let testingApiURL: String = "https://test.blubyn.com/"
    static let productionApiURL: String = "https://app.blubyn.com/"
}
