//
//  ViewController.swift
//  FinalWordsChat
//
//  Created by Brandon Shaw on 6/27/18.
//  Copyright © 2018 Brandon Shaw. All rights reserved.
//

import UIKit
import Hero
import Social

class ViewController: UIViewController {
    var titleLbl: UILabel!
    var subTitle: UILabel!
    var percentTitle: UILabel!
    var batteryPercent: UILabel!
    var enterBtn: UIButton!
    var changNameBtn: UIButton!
    var shareBtn: UIButton!
    var defaults = UserDefaults.standard
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        
        hero.isEnabled = true
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)

        titleLbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 200, y: view.bounds.height / 6, width: 400, height: 85))
        titleLbl.textAlignment = NSTextAlignment.center
        titleLbl.font = UIFont.init(name: "Kefa", size: 42)
        titleLbl.text = "Your Final Words"
        titleLbl.hero.id = "title"
        titleLbl.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        self.view.addSubview(titleLbl)
        
        subTitle = UILabel(frame: CGRect(x: 20, y: view.bounds.height / 4, width: UIScreen.main.bounds.size.width - 40, height: 185))
        subTitle.textAlignment = NSTextAlignment.center
        subTitle.numberOfLines = 0
        subTitle.font = UIFont.init(name: "Ayuthaya", size: 14)
        subTitle.text = "You can only join the chat when you \r\n have 5% or less battery left."
        subTitle.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        self.view.addSubview(subTitle)
        
        percentTitle = UILabel(frame: CGRect(x: 40, y: view.bounds.height / 2 - 60, width: UIScreen.main.bounds.size.width - 80, height: 85))
        percentTitle.textAlignment = NSTextAlignment.center
        percentTitle.font = UIFont.init(name: "Ayuthaya", size: 12)
        percentTitle.text = "current battery %:"
        percentTitle.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        self.view.addSubview(percentTitle)
        
        batteryPercent = UILabel(frame: CGRect(x: 40, y: view.bounds.height / 2, width: UIScreen.main.bounds.size.width - 80, height: 85))
        batteryPercent.textAlignment = NSTextAlignment.center
        batteryPercent.font = UIFont.init(name: "Ayuthaya", size: 65)
        if batteryLevel * 100 >= 20 {
            batteryPercent.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        } else {
            batteryPercent.textColor = UIColor(red: 209.0/255.0, green: 98.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        }
        if batteryLevel == 1.0 {
            batteryPercent.text = "100%"
        } else {
            batteryPercent.text = "\(batteryLevel.cleanValue.replacingOccurrences(of: ".0", with: ""))%"
        }
        self.view.addSubview(batteryPercent)
        
        shareBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 30, y: UIScreen.main.bounds.size.height * 0.65, width: 60, height: 60))
        shareBtn.setBackgroundImage(UIImage(named: "ShareIcon"), for: .normal)
        shareBtn.isEnabled = true
        shareBtn.addTarget(self, action: #selector(twitterAct), for: .touchUpInside)
        self.view.addSubview(shareBtn)
        
        enterBtn = UIButton(frame: CGRect(x: 30, y: UIScreen.main.bounds.size.height * 0.8, width: UIScreen.main.bounds.size.width - 60, height: 55))
        enterBtn.setTitle("Enter Chat", for: UIControlState())
        enterBtn.titleLabel?.font = UIFont.init(name: "Kefa", size: 24)
        enterBtn.layer.cornerRadius = 8
        enterBtn.layer.backgroundColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha: 1.0).cgColor
        enterBtn.setTitleColor(UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1.0), for: UIControlState())
        enterBtn.isEnabled = true
        enterBtn.hero.id = "enter"
        enterBtn.addTarget(self, action: #selector(enterBtnAct), for: .touchUpInside)
        self.view.addSubview(enterBtn)
        
        changNameBtn = UIButton(frame: CGRect(x: 30, y: UIScreen.main.bounds.size.height * 0.85, width: UIScreen.main.bounds.size.width - 60, height: 35))
        let defaults = UserDefaults.standard
        if batteryLevel <= 0.05, let name = defaults.string(forKey: "jsq_name") {
            changNameBtn.setTitle("change display name from \(name)", for: UIControlState())
        } else {
            changNameBtn.isEnabled = false
            changNameBtn.isHidden = true
        }
        changNameBtn.setTitle("change display name from", for: UIControlState())
        changNameBtn.titleLabel?.font = UIFont.init(name: "Ayuthaya", size: 12)
        changNameBtn.setTitleColor(UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0), for: UIControlState())

        changNameBtn.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        self.view.addSubview(changNameBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print("the battery level is now: \(batteryLevel)")
        batteryPercent.text = "\(batteryLevel.cleanValue.replacingOccurrences(of: ".0", with: ""))%"
        if batteryLevel >= 0.20 {
            batteryPercent.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        } else if (batteryLevel <= 0.05) {
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "jsq_name") {
                changNameBtn.setTitle("change display name from \(name)", for: UIControlState())
                changNameBtn.isEnabled = true
                changNameBtn.isHidden = false
            } else {
                changNameBtn.isEnabled = false
                changNameBtn.isHidden = true
            }
        } else {
            batteryPercent.textColor = UIColor(red: 209.0/255.0, green: 98.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cutToChat" {
//            if let _ = defaults.string(forKey: "jsq_name") {
//                let displayname2 = sender as! String
//                print("chatView \(String(describing: displayname2))")
//                let chatVC = segue.destination as! chatViewController
//                chatVC.userDisplayName = displayname2
//            } else {
//                print("Sorry nothing saved in delfauts ")
//            }
//        }
//    }
    
    @objc func twitterAct() {
        let image = UIImage(named: "Icon-196")
        let activityViewController = UIActivityViewController(activityItems: ["Check out this app called 'Your Final Word' on the app store! You can only join the chat when you have 5% battery or less! 😂 Some of the stuff I see...👀 ",image!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.addToReadingList,
                                                        .airDrop,
                                                        .assignToContact,
                                                        .copyToPasteboard,
                                                        .mail,
                                                        .message,
                                                        .openInIBooks,
                                                        .print,
                                                        .saveToCameraRoll,
                                                        .postToWeibo,
                                                        .copyToPasteboard,
                                                        .saveToCameraRoll,
                                                        .postToFlickr,
                                                        .postToVimeo,
                                                        .postToTencentWeibo,
                                                        .markupAsPDF]
        present(activityViewController, animated: true, completion: { })
    }

    @objc func changeName() {
        self.performSegue(withIdentifier: "displayName", sender: self)
    }
    
    @objc func enterBtnAct() {
        print("Enter...\(batteryLevel)")
//        if let _ = defaults.string(forKey: "jsq_id"), let name = defaults.string(forKey: "jsq_name") {
//            print("the name here is: \(name)")
//            self.performSegue(withIdentifier: "cutToChat", sender: self)
//        } else {
//            self.performSegue(withIdentifier: "displayName", sender: self)
//        }
        
        // correct code when below 5%
        
        if batteryLevel <= 0.05 {
            if let _ = defaults.string(forKey: "jsq_id"), let _ = defaults.string(forKey: "jsq_name") {
                self.performSegue(withIdentifier: "cutToChat", sender: self)
            } else {
                self.performSegue(withIdentifier: "displayName", sender: self)
            }
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: enterBtn.center.x - 10, y: enterBtn.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: enterBtn.center.x + 10, y: enterBtn.center.y))
            enterBtn.layer.add(animation, forKey: "position")
            print("Sorry you are too full on batery")
            self.performSegue(withIdentifier: "displayName", sender: self)
        }
    }
}
extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%", self) : String(self * 100)
    }
}
