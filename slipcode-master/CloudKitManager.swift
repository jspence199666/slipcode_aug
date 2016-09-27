//
//  CloudKitManager.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    let container = CKContainer.default()
    
    func getUserID() -> CKRecordID? {
        
        var userID: CKRecordID?
        
        container.fetchUserRecordID {
            (recordID, error) in
            if error == nil {
                userID = recordID
                
            }
        }
        
        return userID
        
    }
    
    
    func loadSlipRecords() -> [Slip]? {
        
        let userID = getUserID()
        var slipsArr: [Slip]?
        
        if let recordID = userID {
            let predicate = NSPredicate(format: "creatorUserRecordID == %@", recordID)
            let query = CKQuery(recordType: "Slips", predicate: predicate)
            
            container.publicCloudDatabase.perform(query, inZoneWith: nil) {
                (records, error) in
                if error != nil {
                    // TODO: - Error handling
                } else {
                    if records != nil {
                        slipsArr = LoadSlipsHelper().convertToSlips(records!)
                    } else {
                        // User has not made any slips yet
                    }
                }
            }

        } else {
            // user has not logged in yet
        }
        
        
        return slipsArr
        
        
    }
    
    
    static func saveNewSlip(_ slip: Slip, completionHandler: @escaping (String) -> ()) {
        
        let record: CKRecord = CKRecord(recordType: "Slip")
        record["accounts"] = SaveSlipsHelper().convertToArr(slip.accounts) as CKRecordValue?
        record["bio"] = slip.bio as CKRecordValue?
        record["nameOfOwner"] = slip.nameOfUser as CKRecordValue?
        record["pictures"] = SaveSlipsHelper().convertToAsset(slip.pictures) as CKRecordValue?
        
        CKContainer.default().publicCloudDatabase.save(record) {
            (record, error) in
            if error != nil {
                // TODO: - Error Handling
            } else {
                if record != nil {
                    print("returning record id")
                    completionHandler(record!.recordID.recordName)
                }
            }
        }
        
    }
    
    
    func loadScanRecords() -> [Scan]? {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Scans", predicate: predicate)
        
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) {
            (records, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if records != nil {
                    
                    // convert record to scan and return
                    
                }
            }
        }
        return nil
        
    }
    
    
    
}
