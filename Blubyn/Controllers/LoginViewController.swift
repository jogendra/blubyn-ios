//
//  ViewController.swift
//  Blubyn
//
//  Created by JOGENDRA on 01/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

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
        logoImageView.addPulseAnimation(from: 0.4, to: 1.0, duration: 0.8, key: "opacity")
        logoImageView.layer.cornerRadius = 8.0
    }

    @IBAction func didTapFbLoginButton(_ sender: Any) {
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logOut()
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self, handler: { result, error   in
            let loginResult: FBSDKLoginManagerLoginResult? = result
            if error != nil {
                debugPrint(error!.localizedDescription)
            } else if (loginResult?.isCancelled)! {
                return
            } else {
                self.firebaseSignIn()
            }
        })
    }
    
    fileprivate func firebaseSignIn() {
        
        BlubynViews.networkActivityIndicator(visible: true, showActivityIndicator: true)
        ActivityIndicator.shared.showProgressView(text: "Loading..", view: view)
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            }
            // User is sign in
            BlubynUserDefaultsService.set(login: true)
            let chatStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let chatViewController = chatStoryboard.instantiateViewController(withIdentifier: "ChatNavVC")
            self.present(chatViewController, animated: true, completion: {
                BlubynViews.networkActivityIndicator(visible: false, showActivityIndicator: false)
                ActivityIndicator.shared.hideProgressView()
            })
        })
    }
    
}

