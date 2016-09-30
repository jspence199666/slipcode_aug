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

class User: NSObject, NSCoding {
    
    static let sharedInstance = User()
    
    var fullName: String = ""
    var accounts: [String: String] = [:]
    var pastPictures: [UIImage] = []
    var slips: [Slip] = [] { didSet { print("added slip") } }
    var scans: [Scan] = []
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        self.fullName = aDecoder.decodeObject(forKey: "name") as! String
        self.accounts = aDecoder.decodeObject(forKey: "accounts") as! [String: String]
        self.pastPictures = aDecoder.decodeObject(forKey: "pastPictures") as! [UIImage]
        self.slips = aDecoder.decodeObject(forKey: "slips") as! [Slip]
        self.scans = aDecoder.decodeObject(forKey: "scans") as! [Scan]
    }
    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.fullName, forKey: "name")
        aCoder.encode(self.accounts, forKey: "accounts")
        aCoder.encode(self.pastPictures, forKey: "pastPictures")
        aCoder.encode(self.slips, forKey: "slips")
        aCoder.encode(self.scans, forKey: "scans")
    }

    
}
    
class HandleUser {
    
    let user = User.sharedInstance
    let defaults = UserDefaults.standard
    
    func save(completionHandler: (_ success: Bool) -> ()) {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: user)
        defaults.set(archivedData, forKey: "user")
        
        defaults.synchronize()
        
        completionHandler(true)
    }
    
    func load() {
        if let loadedUserData = defaults.object(forKey: "user") as? Data {
            let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: loadedUserData) as! User
            
            user.accounts = loadedUser.accounts
            user.fullName = loadedUser.fullName
            user.pastPictures = loadedUser.pastPictures
            user.scans = loadedUser.scans
            user.slips = loadedUser.slips
        }
    }
    
    func setupNewUser() {
        self.save { (success) in
            if success {}
        }
    }
    
}
    



