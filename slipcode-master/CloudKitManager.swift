//
//  CloudKitManager.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class CloudKitManager {
    
    let user = User.sharedInstance
    let helper = CloudKitHelper()
    
    
    func saveSlip(slip: Slip, completionHandler: @escaping (_ recordId: CKRecordID) -> () ) {
        let record = CKRecord(recordType: "Slip")
        record["name"] = slip.nameOfUser as CKRecordValue?
        record["bio"] = slip.bio as CKRecordValue?
        record["accounts"] = helper.convertDictToArr(dict: slip.accounts) as CKRecordValue?
        record["pictures"] = helper.convertUIImagesToAssets(images: slip.pictures) as CKRecordValue?
        DispatchQueue.main.async {
            CKContainer.default().publicCloudDatabase.save(record) {
                (record, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if record != nil {
                        print("saved slip to iCloud")
                        completionHandler(record!.recordID)
                    }
                }
            }
        }
        
    }
    
    func removeSlip(slip: Slip) {
        let recordId = slip.recordId
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordId) {
            (deletedId, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("deleted slip")
            }
        }
        
    }
    
    func getScan(scanResult: String, completionHandler: @escaping (_ scan: Scan) -> ()) {
        let recordId = CKRecordID(recordName: scanResult)
        let newScan = Scan()
        
        print("fetching slip from scan result")
        DispatchQueue.main.async {
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordId) {
                (record, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if record != nil {
                        print("found slip")
                        newScan.accounts = self.helper.convertArrToDict(arr: record!["accounts"] as! [String])
                        newScan.bio = record!["bio"] as! String
                        newScan.name = record!["name"] as! String
                        newScan.pictures = self.helper.convertAssetToUIImage(assets: record!["pictures"] as? [CKAsset])
                        
                        newScan.location = CLLocation()
                        newScan.date = Date()
                        
                        completionHandler(newScan)
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    
}
