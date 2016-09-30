//
//  CloudKitHelper.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/30/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class CloudKitHelper {
    
    let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")!

    
    func convertDictToArr(dict: [String: String]) -> [String] {
        var newArr: [String] = []
        
        for (key,value) in dict {
            let combination = "\(key) \(value)"
            newArr.append(combination)
        }
        
        return newArr
        
    }
    
    func convertArrToDict(arr: [String]) -> [String: String] {
        var newDict: [String: String] = [:]
        
        for item in arr {
            var splitString = item.characters.split{$0 == " "}.map(String.init)
            newDict[splitString[0]] = splitString[1]
        }
        return newDict
    }
    
    func convertAssetToUIImage(assets: [CKAsset]?) -> [UIImage] {
        var newImageArr: [UIImage] = []
        
        guard let ckassets = assets else {
            print("no assets")
            return []
        }
        
        for asset in ckassets {
            let newImage = UIImage(contentsOfFile: asset.fileURL.absoluteString)
            
            if newImage != nil {
                newImageArr.append(newImage!)
            }
        }
        return newImageArr
    }
    
    func convertUIImagesToAssets(images: [UIImage]) -> [CKAsset] {
        var newAssetArr: [CKAsset] = []
        
        for image in images {
            
            do {
                let data = UIImagePNGRepresentation(image)!
                try data.write(to: self.url, options: NSData.WritingOptions.atomicWrite)
                let asset = CKAsset(fileURL: self.url)
                newAssetArr.append(asset)
            }
            catch {
                print("Error writing data", error)
            }
            
        }
        return newAssetArr
        
    }
    

    
}

































