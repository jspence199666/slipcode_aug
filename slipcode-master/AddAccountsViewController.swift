//
//  AddAccountsViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 10/4/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class AddAccountsViewController: UIViewController {
    
    let user = User.sharedInstance
    var activeAccounts: [String] = []
    var accountsToAdd: [String] = []
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!

    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    @IBOutlet weak var check5: UIImageView!
    @IBOutlet weak var check6: UIImageView!
    @IBOutlet weak var check7: UIImageView!
    
    var buttonsArr: [UIButton] = []
    var checkArr: [UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonsArr = [button1, button2, button3, button4, button5, button6, button7]
        checkArr = [check1, check2, check3, check4, check5, check6, check7]
        
        for (key, value) in user.accounts {
            if value != "" {
                activeAccounts.append(key)
            }
        }
        
        print("active accounts: \(activeAccounts.count)")
        
                
        for button in buttonsArr {
            if buttonsArr.index(of: button)! >= activeAccounts.count { button.isHidden = true }
        }
        
        var x = 0
        for account in activeAccounts {
            
            let button = buttonsArr[x]
            
            switch account {
            case "facebook":
                button.setImage(#imageLiteral(resourceName: "facebook100"), for: .normal)
            case "twitter":
                button.setImage(#imageLiteral(resourceName: "twitter100"), for: .normal)
            case "instagram":
                button.setImage(#imageLiteral(resourceName: "Instagram100"), for: .normal)
            case "linkedin":
                button.setImage(#imageLiteral(resourceName: "linkedin100"), for: .normal)
            case "snapchat":
                button.setImage(#imageLiteral(resourceName: "snapchat100"), for: .normal)
            case "phone":
                button.setImage(#imageLiteral(resourceName: "phone100"), for: .normal)
            case "email":
                button.setImage(#imageLiteral(resourceName: "mail100"), for: .normal)
            default: break
            }
            x = x + 1
        }
        
        accountButtonSetActions()

    }
    
    func accountButtonSetActions() {
        for account in self.buttonsArr {
            account.addTarget(self, action: #selector(accountAction(sender:)), for: .touchUpInside)
        }
        
    }
    
    func accountAction(sender: UIButton) {
        
        if checkArr[buttonsArr.index(of: sender)!].isHidden {
            var account: String = ""
            
            switch sender {
            case button1: account = activeAccounts[0]; checkArr[0].isHidden = false;
            case button2: account = activeAccounts[1]; checkArr[1].isHidden = false;
            case button3: account = activeAccounts[2]; checkArr[2].isHidden = false;
            case button4: account = activeAccounts[3]; checkArr[3].isHidden = false;
            case button5: account = activeAccounts[4]; checkArr[4].isHidden = false;
            case button6: account = activeAccounts[5]; checkArr[5].isHidden = false;
            case button7: account = activeAccounts[6]; checkArr[6].isHidden = false;
            default: break
            }
            print(account)
            accountsToAdd.append(account)

        } else {
            var account: String = ""
            
            switch sender {
            case button1: account = activeAccounts[0]; checkArr[0].isHidden = true;
            case button2: account = activeAccounts[1]; checkArr[1].isHidden = true;
            case button3: account = activeAccounts[2]; checkArr[2].isHidden = true;
            case button4: account = activeAccounts[3]; checkArr[3].isHidden = true;
            case button5: account = activeAccounts[4]; checkArr[4].isHidden = true;
            case button6: account = activeAccounts[5]; checkArr[5].isHidden = true;
            case button7: account = activeAccounts[6]; checkArr[6].isHidden = true;
            default: break
            }
            
            print(account)
            self.accountsToAdd = accountsToAdd.filter() { $0 != account }
            
        }

        
        
    }
    
    
    
    
    
}








