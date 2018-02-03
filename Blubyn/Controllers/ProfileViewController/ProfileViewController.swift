//
//  ProfileViewController.swift
//  Blubyn
//
//  Created by JOGENDRA on 03/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: JSTextField!
    
    @IBOutlet weak var lastNameTextField: JSTextField!
    
    @IBOutlet weak var phoneNumberTextField: JSTextField!
    
    @IBOutlet weak var emailTextField: JSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
        textFieldsEditingMode(isEditable: false)
    }
    
    fileprivate func initialUISetups() {
        editProfileButton.layer.borderWidth = 0.5
        editProfileButton.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        editProfileButton.layer.cornerRadius = 0.5 * editProfileButton.frame.width
    }
    
    fileprivate func textFieldsEditingMode(isEditable: Bool) {
        firstNameTextField.isEnabled = isEditable
        lastNameTextField.isEnabled = isEditable
        phoneNumberTextField.isEnabled = isEditable
        emailTextField.isEnabled = isEditable
    }

    @IBAction func didTapEditProfile(_ sender: Any) {
        textFieldsEditingMode(isEditable: true)
    }
    
}
