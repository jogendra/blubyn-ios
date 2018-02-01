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

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
        facebookLoginButton.delegate = self
    }
    
    fileprivate func initialUISetups() {
        
        facebookLoginButton.layer.cornerRadius = DefaultValues.buttonCornerRadiusConstant
    }

    @IBAction func didTapFbLoginButton(_ sender: Any) {
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["publicProfile"], from: self, handler: { result, error   in
            let loginResult: FBSDKLoginManagerLoginResult = result!
            if error != nil {
                debugPrint(error!.localizedDescription)
            } else if loginResult.isCancelled {
                return
            } else {
                
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

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}
