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

enum Cells {
    case chatCell
    case oneWayFlight
    case twoWayFlight
}


class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var sideBar = SideBar()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Send a message..."
        textField.delegate = self
        return textField
    }()
    
    let textView: UIView = {
        let textFieldview = UIView()
        textFieldview.backgroundColor = UIColor.white
        textFieldview.translatesAutoresizingMaskIntoConstraints = false
        return textFieldview
    }()
    
    let cellId = "cellId"
    let oneWayCellId = "oneWayFlightCell"
    let twoWayCellId = "twoWayFlightCell"
    
    var numberOfSections: Int = 3
    var numberOfItemsInASection: Int = 0
    
    var cellType: Cells?
    
    var keyboardHeight: CGFloat = 0.0
    
    var textViewBottomAnchor: NSLayoutConstraint?
    
    var userMessages: [String] = ["Hey there!", "I want to book flight for Pokhara, Nepal", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", "Book a hotel for me near lakeside", "book returning flight"]
    
    var systemMessages: [String] = ["Hello Jogendra!", "Pluto at your service - your guide and concierge to help you with the planning ticket booking and finding new and exotic places.", "Go on! Try me out. Won't take long. I promise."]
    
    var newCellMessages: [String] = []
    
    lazy var messages: [String] = systemMessages + userMessages

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputComponents()
        sideBarSetup()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appThemeColor")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        collectionView?.contentInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 52.0, right: 0)
        collectionView?.backgroundColor = UIColor.chatbackgroundColor
        
        // Register Chat Cell
        collectionView?.register(ChatMessagesCell.self, forCellWithReuseIdentifier: cellId)
        
        // Regsiter One Way Flight Cell
        let oneWayFlightCellNib = UINib(nibName: "OneWayFlightViewCell", bundle: nil)
        collectionView?.register(oneWayFlightCellNib, forCellWithReuseIdentifier: oneWayCellId)
        
        // Register Two Way Flight Cell
        let twoWayFlightCellNib = UINib(nibName: "TwoWayFlightViewCell", bundle: nil)
        collectionView?.register(twoWayFlightCellNib, forCellWithReuseIdentifier: twoWayCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Register Notification, To know When Key Board Appear.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        // Register Notification, To know When Key Board Hides.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // De register the notifications
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func setupInputComponents() {
        
        // Text View setups
        view.addSubview(textView)
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        textViewBottomAnchor = textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        textViewBottomAnchor?.isActive = true
        
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
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
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
    
    // MARK: - Keyboard Events
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        
        textViewBottomAnchor?.constant = -keyboardHeight
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        textViewBottomAnchor?.constant = 0
        
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    // MARK: - Collection View Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return messages.count
        case 1:
            numberOfItemsInASection = 5
            return numberOfItemsInASection
        case 2:
            return 5
        case 3:
            return newCellMessages.count
        default:
            numberOfItemsInASection = 5
            return numberOfItemsInASection
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessagesCell

        let message = messages[indexPath.item]
        cell.chatTextView.text = message

        // Align chat cell according
        if userMessages.contains(message) {

            cell.bubbleView.backgroundColor = UIColor.white
            cell.chatTextView.textColor = UIColor.black

            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false

        } else {

            cell.bubbleView.backgroundColor = UIColor.chatThemeColor
            cell.chatTextView.textColor = UIColor.white

            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
        }

        //Modify the width accordingly
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message).width + 32.0
        
        if indexPath.section == 0 {
            cellType = Cells.chatCell
            return cell
        } else if indexPath.section == 1 {
            let oneWayFlightCell = collectionView.dequeueReusableCell(withReuseIdentifier: oneWayCellId, for: indexPath) as! OneWayFlightViewCell
            cellType = Cells.oneWayFlight
            return oneWayFlightCell
        } else if indexPath.section == 2 {
            let twoWayFlightCell = collectionView.dequeueReusableCell(withReuseIdentifier: twoWayCellId, for: indexPath) as! TwoWayFlightViewCell
            cellType = Cells.twoWayFlight
            return twoWayFlightCell
        } else {
            return cell
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight: CGFloat = 80.0
        let text = messages[indexPath.item]
        cellHeight = estimateFrameForText(text: text).height + 20.0
        
        if indexPath.section == 1 {
            cellHeight = 112
        } else if indexPath.section == 2 {
            cellHeight = 201
        }
        
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //{top, left, bottom, right}
        return UIEdgeInsetsMake(10, 0, 10, 0)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 300.0, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)], context: nil)
    }
    
    @objc fileprivate func didTapSend() {
        
        if let enteredText = inputTextField.text, !enteredText.isEmpty {
//            messages.append(enteredText)
//            userMessages.append(enteredText)
            numberOfSections += 1
            newCellMessages.append(enteredText)
            sendMessageToWebSocket(message: enteredText)
        }
        collectionView?.reloadData()
        collectionView?.numberOfItems(inSection: 0)
        inputTextField.text = nil
    }
    
    fileprivate func sendMessageToWebSocket(message: String) {
        
        guard let firebaseID = BlubynCommons.getUserFirebaseID(), let email = BlubynCommons.getUserFirebaseEmail() else {
            BlubynViews.somethingWentWrongAlertView()
            return
        }
        
        let payload: [String: Any] = ["chat_mode": "bot", "command": "send", "email": email, "lat": 28.6111274, "lng": 77.0544675, "message": message, "msg_type": "text"]
        let params: [String: Any] = ["date": 1518263373401, "instance_id": "eALX5zLlN8E:APA91bHEMGkondcRVSKElUyjif3u7pFaLaNQHykp6j3zAYnwWVqzxL6owykwLWXHPO6_zB8OfaoEv4886OJFblUYey53EEUAoMSF9BkTPxvgiteJYnb78e2Pn-Zqd6Fmrc_vAv05IXm_", "last_message_id": 0, "last_message_time": 0,"payload": payload, "type": 0, "user_firebase_id": firebaseID]
        
        BlubynAPI.sendMessage(params: params, completion: { parsedJSON, status, error in
            
            if parsedJSON != nil {
                print(parsedJSON)
            }
        })
    }
    
    fileprivate func sideBarSetup() {
        
        sideBar = SideBar(sourceView: self.view, menuItems: ["My Trips", "Experiences (Coming Soon)", "Share With Friends", "Help and Feedback", "Settings", "Profile", "Like us on Facebook", "Rate us on App Store", "Logout"])
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
        case 6:
            break
        case 7:
            break
        case 8:
            logoutAndGoToLogin()
        default:
            break
        }
    }
    
    fileprivate func logoutAndGoToLogin() {
        ActivityIndicator.shared.showProgressView()
        BlubynUserDefaultsService.set(login: false)
        BlubynCommons.firebaseSignOut()
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginViewController, animated: true, completion: {
            ActivityIndicator.shared.hideProgressView()
        })
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
