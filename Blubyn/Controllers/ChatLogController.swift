//
//  ChatLogController.swift
//  Blubyn
//
//  Created by JOGENDRA on 02/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

fileprivate enum DefaultConstants {
    
    static let sendButtonImageName: String = "send-icon"
    static let voiceButtonImageName: String = "microphone"
}


class ChatLogController: UICollectionViewController {
    
    fileprivate var sideBar = SideBar()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Send a Message..."
        textField.delegate = self
        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputComponents()
        sideBarSetup()
    }

    fileprivate func setupInputComponents() {
        let textView = UIView()
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        let voiceButton = UIButton(type: .system)
        let voiceButtonImage = UIImage(named: DefaultConstants.voiceButtonImageName)
        voiceButton.setImage(voiceButtonImage, for: .normal)
        textView.addSubview(voiceButton)
        voiceButton.translatesAutoresizingMaskIntoConstraints = false
        voiceButton.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        voiceButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        voiceButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        voiceButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        let sendButton = UIButton(type: .system)
        let sendButtonImage = UIImage(named: DefaultConstants.sendButtonImageName)
        sendButton.setImage(sendButtonImage, for: .normal)
        textView.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: voiceButton.leadingAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        textView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 4.0).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4.0).isActive = true
        inputTextField.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: textView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let separator = UIView()
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        textView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
    }
    
    fileprivate func sideBarSetup() {
        sideBar = SideBar(sourceView: self.view, menuItems: ["Chat", "Hot Deals", "My Trips", "Experiences", "Settings", "Profile"])
        sideBar.delegate = self
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        sideBar.showSideBar(!sideBar.isSideBarOpen)
    }
    
    
    @IBAction func didTapHelp(_ sender: Any) {
        
    }
    
}

extension ChatLogController: SideBarDelegate {
    
    func SideBarDidSelectButtonAtIndex(_ index: Int) {
        
        switch index {
        case 0:
            sideBar.showSideBar(!sideBar.isSideBarOpen)
        case 1:
            sideBar.showSideBar(!sideBar.isSideBarOpen)
        case 2:
            sideBar.showSideBar(!sideBar.isSideBarOpen)
        case 3:
            sideBar.showSideBar(!sideBar.isSideBarOpen)
        case 4:
            let settingStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let settingsViewController = settingStoryboard.instantiateViewController(withIdentifier: "settingvc")
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        case 5:
            let profileStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "profilevc")
            self.navigationController?.pushViewController(profileViewController, animated: true)
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputTextField.endEditing(true)
    }
    
}

extension ChatLogController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        return true
    }
}
