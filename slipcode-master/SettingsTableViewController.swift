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
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var snapchatField: UITextField!
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var linkedInField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameField.text = user.fullName
        bioField.text = user.bio
        facebookField.text = user.accounts?["facebook"]
        twitterField.text = user.accounts?["twitter"]
        snapchatField.text = user.accounts?["snapchat"]
        instagramField.text = user.accounts?["instagram"]
        linkedInField.text = user.accounts?["linkedin"]
        phoneField.text = user.accounts?["phone"]
        emailField.text = user.accounts?["email"]
        
        
    }

    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        
        let name = nameField.text ?? ""
        let bio = bioField.text ?? ""
        let accounts = ["facebook": facebookField.text ?? "",
                        "twitter": twitterField.text ?? "",
                        "snapchat": snapchatField.text ?? "",
                        "instagram": instagramField.text ?? "",
                        "linkedin": linkedInField.text ?? "",
                        "phone": phoneField.text ?? "",
                        "email": emailField.text ?? ""]
        
        
        
        self.user.fullName = name
        self.user.bio = bio
        self.user.accounts = accounts
        
        print("saving name: \(name) bio: \(bio) accounts: \(accounts["facebook"]) \(accounts["twitter"]) \(accounts["snapchat"]) \(accounts["instagram"]) \(accounts["linkedin"]) \(accounts["phone"]) \(accounts["email"]) ")
        
        
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
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
