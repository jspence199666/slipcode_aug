//
//  LoginViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    var user = User.sharedInstance
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tryAgain(_ sender: AnyObject) {
        
        CloudKitAuthentication().checkLoginStatus { (success) in
            if success {
                if self.nameTextField.text != nil {
                    UserDefaults.standard.set(true, forKey: "loggedInStatus")
                    self.user.fullName = self.nameTextField.text
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! SlipViewController
                    self.present(viewController, animated: true, completion: nil)
                    
                } else {
                    print("text field is empty")
                }
            } else {
                print("not logged into iCloud")
            }

        }
    }
    
    
    
}
