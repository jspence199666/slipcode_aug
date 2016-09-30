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
    let handler = HandleUser()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
    }

    
    
    @IBAction func tryAgain(_ sender: AnyObject) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.iCloudLogin(completionHandler: { (success) -> () in
            if success {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if let name = self.nameTextField.text {
                    self.user.fullName = name
                    self.handler.save(completionHandler: { (success) in
                        
                        UserDefaults.standard.set(true, forKey: "LoggedInStatus")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        self.present(viewController, animated: false, completion: nil)
                    })
                    
                    
                    
                } else {
                    print("Text field not filled in")
                }
                
                
            } else {
                print("user not logged into iCloud")
            }
        })
    }
    
    func iCloudLogin(completionHandler: @escaping (_ success: Bool) -> ()) {
        CloudKitAuthentication.requestPermission { (granted) -> () in
            if !granted {
                print("Error not granted")
            } else {
                print("granted")
                CloudKitAuthentication.getUser(completionHandler: { (success) -> () in
                    if success {
                        print("got user")
                        completionHandler(true)
                    } else {
                        // TODO: - error handling
                    }
                })
            }
        }
    }
}




