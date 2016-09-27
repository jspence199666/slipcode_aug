//
//  CloudKitAuthentication.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/22/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class CloudKitAuthentication {
    
    let container = CKContainer.default()
    let user = User.sharedInstance
    static let sharedAuthenticationInstance = CloudKitAuthentication()
    var isLoggedIn: Bool?
    
    
    enum UserRecordAttributes: String {
        case name, bio, pictures, scans, slips, accounts
    }

    func checkLoginStatus(completionHandler: @escaping (_ success: Bool) -> ()) {
        
        
        
        CKContainer.default().requestApplicationPermission(CKApplicationPermissions.userDiscoverability) {
            (applicationPermissionStatus, error) in
            CKContainer.default().accountStatus() {
                accountStatus, error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if accountStatus == CKAccountStatus.available {
                        print("Account is Available")
                        CKContainer.default().fetchUserRecordID() {
                            recordId, error in
                            if error != nil {
                                print(error?.localizedDescription)
                                
                            } else {
                                print(recordId!.recordName + " logged in")
                                print("set true")
                                completionHandler(true)
                            }
                        }
                    }
                    if accountStatus == CKAccountStatus.couldNotDetermine {
                        print("Could not determine")
                    }
                    if accountStatus == CKAccountStatus.restricted {
                        print("Restricted account")
                    }
                    if accountStatus == CKAccountStatus.noAccount {
                        print("No Account")
                    }
                }
                
            }
        }
        
    }
    
    
    
    func setDefaults() {
        
        
        if UserDefaults().bool(forKey: "isLoggedIn") == false {
            UserDefaults().set("", forKey: "bio")
            UserDefaults().set(["":""], forKey: "accounts")
            UserDefaults().set("", forKey: "name")
            
            print("set blank defaults")
            
            // Configure first time on the app here
        }
    }
    
    
    
}


























