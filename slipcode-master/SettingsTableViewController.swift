//
//  SettingsTableViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/21/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
    var user = User.sharedInstance
    var handler = HandleUser()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var snapchatField: UITextField!
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var linkedInField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var fieldArr: [UITextField]?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        fieldArr = [facebookField, twitterField, snapchatField, instagramField, linkedInField, phoneField, emailField]
        
        nameField.text = user.fullName
        facebookField.text = user.accounts["facebook"]
        twitterField.text = user.accounts["twitter"]
        snapchatField.text = user.accounts["snapchat"]
        instagramField.text = user.accounts["instagram"]
        linkedInField.text = user.accounts["linkedin"]
        phoneField.text = user.accounts["phone"]
        emailField.text = user.accounts["email"]
        
        
    }

    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        
        let name = nameField.text ?? ""
        var accounts: [String: String] = [:]
        
        for field in fieldArr! {
            
            if let input = field.text {
                
                switch field {
                case facebookField: accounts["facebook"] = input
                case twitterField: accounts["twitter"] = input
                case snapchatField: accounts["snapchat"] = input
                case instagramField: accounts["instagram"] = input
                case linkedInField: accounts["linkedin"] = input
                case phoneField: accounts["phone"] = input
                case emailField: accounts["email"] = input
                default: break
                }
                
            }
            
        }
        
        
        self.user.fullName = name
        self.user.accounts = accounts
        handler.save { (success) in
            if success {}
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
