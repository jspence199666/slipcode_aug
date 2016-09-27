//
//  User.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/22/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class User {
    
    static let sharedInstance = User()
    
    var fullName: String? = UserDefaults.standard.object(forKey: "name") as? String {
        didSet {
            UserDefaults.standard.set(self.fullName, forKey: "name")
            print("set name")
        }
    }
    
    var bio: String? = UserDefaults.standard.object(forKey: "bio") as? String {
        didSet {
            UserDefaults.standard.set(self.bio, forKey: "bio")
            print("set bio")
        }
    }
    
    var accounts: [String: String]? = UserDefaults.standard.object(forKey: "accounts") as? [String: String] {
        didSet {
            UserDefaults.standard.set(self.accounts, forKey: "accounts")
            print("set accounts")
        }
    }
    
    
    var pastPictures: [UIImage]?
    var slips: [Slip] = []
    var scans: [Scan] = []

    
}
