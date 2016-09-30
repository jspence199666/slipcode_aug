//
//  Slip.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class Slip: NSObject, NSCoding {
    
    var bio: String = ""
    var accounts: [String: String] = [:]
    var pictures: [UIImage] = []
    var scannedMe: [ScannedMe] = []
    var nameOfUser: String = ""
    var recordId: CKRecordID?
    
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        self.bio = aDecoder.decodeObject(forKey: "bio") as! String
        self.accounts = aDecoder.decodeObject(forKey: "accounts") as! [String: String]
        self.pictures = aDecoder.decodeObject(forKey: "pictures") as! [UIImage]
        self.scannedMe = aDecoder.decodeObject(forKey: "scannedMe") as! [ScannedMe]
        self.nameOfUser = aDecoder.decodeObject(forKey: "name") as! String
        self.recordId = CKRecordID(recordName: (aDecoder.decodeObject(forKey: "recordId") as! String))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.bio, forKey: "bio")
        aCoder.encode(self.accounts, forKey: "accounts")
        aCoder.encode(self.pictures, forKey: "pictures")
        aCoder.encode(self.scannedMe, forKey: "scannedMe")
        aCoder.encode(self.nameOfUser, forKey: "name")
        aCoder.encode(self.recordId?.recordName, forKey: "recordId")
    }
    
    func createQRCode(completionHandler: (_ image: CIImage) -> ()) {
        var newFilter: CIImage?
        let recordName = recordId?.recordName
        
        guard let stringForCode = recordName else {
            return
        }
        
        let dataForQRCode = (stringForCode)
        let data = dataForQRCode.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        newFilter =  filter?.outputImage
        
        if newFilter != nil {
            completionHandler(newFilter!)
        } else {
            print("Error making QR from message")
        }
        
    }
    
    
    
}
