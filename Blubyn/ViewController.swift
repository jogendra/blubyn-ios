//
//  ViewController.swift
//  Blubyn
//
//  Created by JOGENDRA on 01/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

fileprivate enum DefaultValues {
    static let buttonCornerRadiusConstant: CGFloat = 4.0
}

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
    }
    
    fileprivate func initialUISetups() {
        
        facebookLoginButton.layer.cornerRadius = DefaultValues.buttonCornerRadiusConstant
    }

}

