//
//  CameraViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/17/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftQRCode
import CloudKit

class CameraViewController: UIViewController {
    
    var scan = Scan()
    var user = User.sharedInstance
    
    @IBOutlet weak var cameraView: UIView!
    
    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.prepareScan(cameraView) { stringValue -> () in
            self.getRecord(scanResults
                : stringValue)
        }
        scanner.scanFrame = cameraView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // start scan
        scanner.startScan()
    }
    
    func getRecord(scanResults: String) {
        
        let recordID = CKRecordID(recordName: scanResults)
        
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) {
            (record, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if record != nil {
                    
                    let scanRecord = CKRecord(recordType: "scan")
                    scanRecord["nameOfCreator"] = record!["nameOfUser"]
                    scanRecord["bio"] = record!["bio"]
                    scanRecord["accounts"] = record!["accounts"]
                    scanRecord["pictures"] = record!["pictures"]
                    scanRecord["location"] = "" as CKRecordValue? // Get current Location
                    scanRecord["date"] = "" as CKRecordValue? // Get current date
                    
                    CKContainer.default().privateCloudDatabase.save(scanRecord, completionHandler: {
                        (record, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            if record != nil {
                                
                                self.scan.bio = record!["bio"] as! String
                                self.scan.location = record!["location"] as? CLLocation
                                self.scan.accounts = [:] // convert record to dict
                                self.scan.date = record!["date"] as? NSDate
                                self.scan.pictures = record!["pictures"] as! [UIImage]
                                self.scan.name = record!["nameOfCreator"] as! String
                                
                                self.user.scans.append(self.scan)
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let viewController = storyboard.instantiateViewController(withIdentifier: "ScanDetailViewController") as! ScanDetailViewController
                                viewController.scan = self.scan
                                self.present(viewController, animated: true, completion: nil)
                                
                            }
                        }
                    })
                    
                }
            }
        }
        
    }
    
    
}
