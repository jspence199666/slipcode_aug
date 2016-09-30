//
//  Scan.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class Scan: NSObject, NSCoding {
    
    var name: String = ""
    var bio: String = ""
    var accounts: [String: String] = [:]
    var pictures: [UIImage] = []
    var location: CLLocation?
    var date: Date?
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.bio = aDecoder.decodeObject(forKey: "bio") as! String
        self.accounts = aDecoder.decodeObject(forKey: "accounts") as! [String: String]
        self.pictures = aDecoder.decodeObject(forKey: "pictures") as! [UIImage]
        self.location = aDecoder.decodeObject(forKey: "loaction") as? CLLocation
        self.date = aDecoder.decodeObject(forKey: "date") as? Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.accounts, forKey: "accounts")
        aCoder.encode(self.bio, forKey: "bio")
        aCoder.encode(self.pictures, forKey: "pictures")
        aCoder.encode(self.location, forKey: "location")
        aCoder.encode(self.date, forKey: "date")
    }
    
    
}
