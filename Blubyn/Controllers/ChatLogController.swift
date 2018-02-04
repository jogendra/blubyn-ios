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


class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var sideBar = SideBar()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Send a Message..."
        textField.delegate = self
        return textField
    }()
    
    let cellId = "cellId"
    
    let messages: [String] = ["Hey there!", "My name is jogendra and i am studyng at indian institute of technology banaras hindu university varanasi", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries", "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputComponents()
        sideBarSetup()
        
        collectionView?.contentInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 52.0, right: 0)
        collectionView?.register(ChatMessagesCell.self, forCellWithReuseIdentifier: cellId)
    }

    fileprivate func setupInputComponents() {
        let textView = UIView()
        textView.backgroundColor = UIColor.white
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
    
    // MARK: - Collection View Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessagesCell
        let message = messages[indexPath.item]
        cell.chatTextView.text = message
        
        //Modify the width accordingly
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message).width + 32.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight: CGFloat = 80.0
        let text = messages[indexPath.item]
        cellHeight = estimateFrameForText(text: text).height + 20.0
        
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.resignFirstResponder()
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200.0, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)], context: nil)
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
        inputTextField.resignFirstResponder()
        inputTextField.endEditing(true)
    }
    
}

extension ChatLogController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        return true
    }
}
