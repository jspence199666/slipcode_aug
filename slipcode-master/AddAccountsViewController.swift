//
//  AddAccountsViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/25/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit


class AddAccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user = User.sharedInstance
    var connectedAccounts: [String] = []
    var accountsToAdd: [String] = []
    var slip: Slip?
    
    @IBOutlet weak var accountsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let connectedAccountsDict = user.accounts!
        
        self.connectedAccounts = getAccountsArr(connectedAccountsDict)
        
        self.accountsTableView.allowsMultipleSelection = true
        
    }
    
    fileprivate func getAccountsArr(_ accountsDict: [String: String]) -> [String] {
        
        var accountsArr: [String] = []
        
        for (key, value) in accountsDict {
            if key != "" {
                if value != "" {accountsArr.append(key)}
            }
        }
        return accountsArr
    }
    
    
    @IBAction func save(_ sender: AnyObject) {
        
        let userAccounts: [String: String] = user.accounts!
        var userAccountsToAdd: [String: String] = [:]
        
        for (key, value) in userAccounts {
            for account in accountsToAdd {
                if key == account {
                    userAccountsToAdd[key] = value
                }
            }
            
        }
        
        slip?.accounts = userAccountsToAdd
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectedAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Account", for: indexPath)
        cell.selectionStyle = .none
        print("setting up \(connectedAccounts[indexPath.row])")
        cell.textLabel!.text = connectedAccounts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType .checkmark
        
        accountsToAdd.append(connectedAccounts[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType .none
        
        self.accountsToAdd = self.accountsToAdd.filter {$0 != connectedAccounts[indexPath.row]}
    }
    
    
    
    
    
    

}
