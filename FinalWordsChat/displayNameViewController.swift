//
//  displayNameViewController.swift
//  FinalWordsChat
//
//  Created by Brandon Shaw on 6/27/18.
//  Copyright © 2018 Brandon Shaw. All rights reserved.
//

import UIKit
import Hero

class displayNameViewController: UIViewController, UITextFieldDelegate {
    var titleLbl: UILabel!
    var subTitle: UILabel!
    var displayNameField: UITextField!
    var devider1: UIView!
    var enterBtn: UIButton!
    var termsBtn: UIButton!
    var alertTerms = UIAlertController(style: .actionSheet)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 73.0/255.0, green: 73.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        
        hero.isEnabled = true
        
        let backBtn = UIButton(frame: CGRect(x: 30, y: view.bounds.height / 10, width: 26, height: 19))
        let backBtn22 = UIImage(named: "backBtn")
        backBtn.setImage(backBtn22 , for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
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
        subTitle.text = "Type your display name below:"
        subTitle.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        self.view.addSubview(subTitle)
        
        displayNameField = UITextField(frame: CGRect(x: 20, y: UIScreen.main.bounds.size.height * 0.45, width: view.bounds.width - 40, height: 40))
        displayNameField.placeholder = "display name"
        displayNameField.delegate = self
        displayNameField.font = UIFont.init(name: "Kefa", size: 28)
        displayNameField.borderStyle = UITextBorderStyle.none
        displayNameField.autocorrectionType = UITextAutocorrectionType.no
        displayNameField.autocapitalizationType = UITextAutocapitalizationType.words
        displayNameField.keyboardType = UIKeyboardType.default
        displayNameField.returnKeyType = UIReturnKeyType.next
        displayNameField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        displayNameField.textAlignment = .center
        displayNameField.textColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        displayNameField.tag = 0
        displayNameField.keyboardAppearance = UIKeyboardAppearance.dark
        displayNameField.addTarget(self, action: #selector(textDidChange), for: UIControlEvents.editingChanged)
        self.view.addSubview(displayNameField)
        
        devider1 = UIView(frame: CGRect(x: 20, y: UIScreen.main.bounds.size.height * 0.45 + 42, width: view.bounds.width - 40, height: 1.5))
        devider1.backgroundColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        self.view.addSubview(devider1)
        
        enterBtn = UIButton(frame: CGRect(x: 30, y: UIScreen.main.bounds.size.height * 0.5 + 45, width: UIScreen.main.bounds.size.width - 60, height: 55))
        enterBtn.setTitle("Start Chat", for: UIControlState())
        enterBtn.titleLabel?.font = UIFont.init(name: "Kefa", size: 24)
        enterBtn.layer.cornerRadius = 8
        enterBtn.layer.backgroundColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha: 1.0).cgColor
        enterBtn.setTitleColor(UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1.0), for: UIControlState())
        enterBtn.isEnabled = true
        enterBtn.hero.id = "enter"
        enterBtn.addTarget(self, action: #selector(startBtnAct), for: .touchUpInside)
        self.view.addSubview(enterBtn)
        
        termsBtn = UIButton(frame: CGRect(x: 30, y: view.bounds.height / 10, width: UIScreen.main.bounds.size.width - 60, height: 35))
        termsBtn.setTitle("Terms of Service", for: UIControlState())
        termsBtn.titleLabel?.font = UIFont.init(name: "Ayuthaya", size: 10)
        termsBtn.setTitleColor(UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0), for: UIControlState())
        
        termsBtn.addTarget(self, action: #selector(terms), for: .touchUpInside)
        self.view.addSubview(termsBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayNameField.becomeFirstResponder()
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        
        if ((displayNameField.text?.characters.count)! >= 2 && (displayNameField.text?.characters.count)! < 15) {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.enterBtn.isEnabled = true
                self.enterBtn.layer.shadowOpacity = 0.2
                self.enterBtn.layer.shadowOffset = CGSize.zero
                self.enterBtn.layer.shadowColor = UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1.0).cgColor
                self.enterBtn.layer.shadowRadius = 8
                self.enterBtn.layer.backgroundColor = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0).cgColor
                self.enterBtn.setTitleColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: UIControlState())
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.enterBtn.isEnabled = false
                self.enterBtn.layer.shadowOpacity = 0.0
                self.enterBtn.layer.shadowColor = UIColor.clear.cgColor
                self.enterBtn.layer.shadowRadius = 0
                self.enterBtn.layer.backgroundColor = UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha: 1.0).cgColor
                self.enterBtn.setTitleColor(UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1.0), for: UIControlState())
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatView" {
            print("chatView")
            //let chatVC = segue.destination as! chatViewController
            //chatVC.userDisplayName = displayNameField.text!
        }
    }
    
    @objc func startBtnAct() {
        if ((displayNameField.text?.characters.count)! >= 2 && (displayNameField.text?.characters.count)! < 15) {
            print("Start chat")
            let defaults = UserDefaults.standard
            defaults.set(displayNameField.text, forKey: "jsq_name")
            defaults.synchronize()
            self.performSegue(withIdentifier: "chatView", sender: self)

        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: enterBtn.center.x - 10, y: enterBtn.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: enterBtn.center.x + 10, y: enterBtn.center.y))
            
            enterBtn.layer.add(animation, forKey: "position")
        }
    }
    
    @objc func terms() {
        let text: [AttributedTextBlock] = [
            .normal(""),
            .header1("TERMS OF SERVICE AGREEMENT"),
            .header2("Standard Terms of Service Policy."),
            .normal("There are a few important things to keep in mind when chatting in Your Final Words:"),
            .list("Keep hate speach out of conversation."),
            .list("No exchanging contact information or exposing anyone."),
            .normal("*You retain all intellectual property rights over all content in your account. Your profile and any material materials uploaded also remains yours. Your Final Words has the right in its sole discretion to refuse or remove any content that is available through the Your Final Words Service.")]
        alertTerms.addTextViewer(text: .attributedText(text))
        alertTerms.addAction(title: "OK", style: .cancel)
        self.present(alertTerms, animated: true, completion: nil)
    }
    
    @objc func back(_ sender: UIButton!) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
