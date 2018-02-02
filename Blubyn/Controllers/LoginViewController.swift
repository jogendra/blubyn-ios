//
//  ViewController.swift
//  Blubyn
//
//  Created by JOGENDRA on 01/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

fileprivate enum DefaultValues {
    static let buttonCornerRadiusConstant: CGFloat = 4.0
}

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
    }
    
    fileprivate func initialUISetups() {
        
        facebookLoginButton.layer.cornerRadius = DefaultValues.buttonCornerRadiusConstant
    }

    @IBAction func didTapFbLoginButton(_ sender: Any) {
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self, handler: { result, error   in
            let loginResult: FBSDKLoginManagerLoginResult = result!
            if error != nil {
                debugPrint(error!.localizedDescription)
            } else if loginResult.isCancelled {
                return
            } else {
                self.fetchUserProfileData()
            }
        })
    }
    
    // Fetch User's Public Facebook Profile Data
    fileprivate func fetchUserProfileData() {
        let params = ["fields": "email, first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).start(completionHandler: { connection, result, error in
            print(result.debugDescription)
        })
    }
}

