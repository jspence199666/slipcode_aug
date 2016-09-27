//
//  CloudKitHelper.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit


class LoadSlipsHelper {
    
    
    open func convertToSlips(_ records: [CKRecord]) -> [Slip] {
        
        var slipsArr: [Slip] = []
        
        for record in records {
            
            let newSlip = Slip()
            
            newSlip.accounts = getAccountsFromSlip(record["accounts"] as? [String] ?? [])
            newSlip.bio = record["bio"] as? String ?? ""
            newSlip.scannedMe = [] // get from user IDs that are in the slip arr
            newSlip.pictures = getPicturesFromSlip(record)
            newSlip.qrCode = record.recordID.recordName
            
            slipsArr.append(newSlip)
            
        }
        
        return slipsArr
        
        
    }
    
    
    fileprivate func getAccountsFromSlip(_ accountsStringArr: [String]) -> [String: String] {
        
        var accountsDict: [String: String] = [:]
        
        for item in accountsStringArr {
            let holderArr = item.characters.split(separator: " ").map(String.init)
            accountsDict[holderArr[0]] = holderArr[1]
            
            
        }
        
        return accountsDict
        
    }
    
    fileprivate func getScannedMeFromSlip(_ userRecords: [CKRecordID]) -> [ScannedMe] {
        
        let scannedMeArr: [ScannedMe] = []
        
        for item in userRecords {
            
            //TODO: - get users from their recordID and convert to ScannedMe model and add to arr
            
        }
        
        return scannedMeArr
        
    }
    
    fileprivate func getPicturesFromSlip(_ record: CKRecord) -> [UIImage] {
        
        var imagesArr: [UIImage] = []
        
        if let assets = record["pictures"] as? [CKAsset] {
            
            for asset in assets {
                
                do {
                    let imageData: Data
                    try imageData = Data(contentsOf: asset.fileURL)
                    let image = UIImage(data: imageData as Data)
                    imagesArr.append(image!)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            }
        }
        
        return imagesArr
        
    }
    
    
    
}


class SaveSlipsHelper {
    
    open func convertToAsset(_ images: [UIImage]) -> [CKAsset] {
        
        var assets: [CKAsset] = []
        
        for image in images {
            do {
                let data = UIImagePNGRepresentation(image)!
                try data.write(to: URL(fileURLWithPath: "temp_url.png"), options: Data.WritingOptions.atomicWrite)
                let asset = CKAsset(fileURL: URL(fileURLWithPath: "temp_url.png"))
                assets.append(asset)
            }
            catch {
                print("Error writing data", error)
            }
        }
        
        return assets

        
    }
    
    open func convertToArr(_ dict: [String: String]) -> [String] {
        var arr: [String] = []
        
        for (key, value) in dict {
            arr.append("\(key) \(value)")
        }
        
        return arr
    }
    
}
































