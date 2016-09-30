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
    
    static let container = CKContainer.default()
    var user = User.sharedInstance
    
    
    static func requestPermission(completionHandler: @escaping (_ granted: Bool) -> ()) {
        container.requestApplicationPermission(CKApplicationPermissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            if applicationPermissionStatus == CKApplicationPermissionStatus.granted {
                completionHandler(true)
            } else {
                // very simple error handling
                completionHandler(false)
            }
        })
    }
    
    static func getUser(completionHandler: @escaping (_ success: Bool) -> ()) {
        
        container.fetchUserRecordID {
            (userRecordID, error) in
            if error != nil {
                print(error?.localizedDescription)
                completionHandler(false)
            } else {
                
                self.container.privateCloudDatabase.fetch(withRecordID: userRecordID!, completionHandler: {
                    (record, error) in
                    if (error != nil) {
                        print(error?.localizedDescription)
                        completionHandler(false)
                    } else {
                        completionHandler(true)
                    }
                })
                
            }
        }
    }
    
    
    
}


























