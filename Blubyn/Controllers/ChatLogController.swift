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
    
    var cellType: Cells?
    
    var keyboardHeight: CGFloat = 0.0
    
    var textViewBottomAnchor: NSLayoutConstraint?
    
    var userMessages: [String] = ["Hey there!", "I want to book flight for Pokhara, Nepal", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", "Book a hotel for me near lakeside", "book returning flight"]
    
    var systemMessages: [String] = ["Hello Jogendra!", "Pluto at your service - your guide and concierge to help you with the planning ticket booking and finding new and exotic places.", "Go on! Try me out. Won't take long. I promise."]
    
    lazy var messages: [String] = systemMessages + userMessages

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputComponents()
        sideBarSetup()
        
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
            return 5
        case 2:
            return 5
        default:
            return messages.count
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
        } else {
            let twoWayFlightCell = collectionView.dequeueReusableCell(withReuseIdentifier: twoWayCellId, for: indexPath) as! TwoWayFlightViewCell
            cellType = Cells.twoWayFlight
            return twoWayFlightCell
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellHeight: CGFloat = 80.0
        let text = messages[indexPath.item]
        cellHeight = estimateFrameForText(text: text).height + 20.0
        
        if cellType == Cells.oneWayFlight {
            cellHeight = 112
        } else if cellType == Cells.twoWayFlight {
            cellHeight = 201
        }
        
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.resignFirstResponder()
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 300.0, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)], context: nil)
    }
    
    @objc fileprivate func didTapSend() {
        
        if let enteredText = inputTextField.text {
            messages.append(enteredText)
        }
        collectionView?.reloadData()
        inputTextField.text = nil
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
