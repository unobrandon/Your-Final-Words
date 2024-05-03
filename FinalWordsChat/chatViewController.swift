//
//  chatViewController.swift
//  FinalWordsChat
//
//  Created by Brandon Shaw on 6/27/18.
//  Copyright © 2018 Brandon Shaw. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseDatabase

class chatViewController: JSQMessagesViewController {
    var userDisplayName = String()
    var query: DatabaseQuery!
    var ref: DatabaseReference!
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    var messages = [JSQMessage]()
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        senderId = "1234"
        senderDisplayName = "userDisplayName"
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
        
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("Done", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        let defaults = UserDefaults.standard
        if  let id = defaults.string(forKey: "jsq_id"), let name = defaults.string(forKey: "jsq_name") {
            senderId = id
            senderDisplayName = name
        } else {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = ""
            defaults.set(senderId, forKey: "jsq_id")
            defaults.set(senderDisplayName, forKey: "jsq_name")
            defaults.synchronize()
        }
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        collectionView.keyboardDismissMode = .onDrag
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.init(name: "Kefa", size: 22)!]
        self.navigationController?.navigationBar.frame.size.height = 80
        self.checkChatGroup()
    }
    
    @objc func backAction() {
        view.endEditing(true)
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print("the battery level is now: \(batteryLevel)")
        self.query.removeAllObservers()
        self.messages.removeAll()
        self.checkChatGroup()
    }
    
    func checkChatGroup() {
        if batteryLevel == 0.05 {
            self.title = "5% Group Chat"
            query = Constants.refs.databaseChatsFive.queryLimited(toLast: 15)
        } else if (batteryLevel == 0.04) {
            self.title = "4% Group Chat"
            query = Database.database().reference().child("chatPercent4").queryLimited(toLast: 15)
        } else if (batteryLevel == 0.03) {
            self.title = "3% Group Chat"
            query = Database.database().reference().child("chatPercent3").queryLimited(toLast: 15)
        } else if (batteryLevel == 0.02) {
            self.title = "2% Group Chat"
            query = Database.database().reference().child("chatPercent2").queryLimited(toLast: 15)
        } else if (batteryLevel == 0.01) {
            self.title = "1% Group Chat"
            query = Database.database().reference().child("chatPercent1").queryLimited(toLast: 15)
        } else {
            self.title = "5% Group Chat"
            query = Constants.refs.databaseChatsFive.queryLimited(toLast: 15)
        }
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty {
                if let message = JSQMessage(senderId: id, displayName: name, text: text) {
                    self?.messages.append(message)
                    self?.finishReceivingMessage()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        if batteryLevel == 0.05 {
            self.title = "5% Group Chat"
            ref = Constants.refs.databaseChatsFive.childByAutoId()
        } else if (batteryLevel == 0.04) {
            self.title = "4% Group Chat"
            ref = Database.database().reference().child("chatPercent4").childByAutoId()
        } else if (batteryLevel == 0.03) {
            self.title = "3% Group Chat"
            ref = Database.database().reference().child("chatPercent3").childByAutoId()
        } else if (batteryLevel == 0.02) {
            self.title = "2% Group Chat"
            ref = Database.database().reference().child("chatPercent2").childByAutoId()
        } else if (batteryLevel == 0.01) {
            self.title = "1% Group Chat"
            ref = Database.database().reference().child("chatPercent1").childByAutoId()
        } else {
            self.title = "5% Group Chat"
            ref = Constants.refs.databaseChatsFive.childByAutoId()
        }
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        ref.setValue(message)
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
}
