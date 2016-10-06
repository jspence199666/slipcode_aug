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
import SimpleAlert

class CameraViewController: UIViewController {
    
    //MARK: - Setup Variables
    var user = User.sharedInstance
    let handler = HandleUser()
    let scanner = QRCode()
    let ckmanager = CloudKitManager()
    
    var scanDetailViewController: ScanDetailViewController?
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        scanDetailViewController = storyboard.instantiateViewController(withIdentifier: "ScanDetailViewController") as? ScanDetailViewController
        
        scanner.prepareScan(cameraView) { stringValue -> () in
            
            print(stringValue)
            self.getRecord(scanResults: stringValue)
        }
        scanner.scanFrame = cameraView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        // start scan
        scanner.startScan()
    }
    
    //MARK: - Cloudkit Methods
    
    func getRecord(scanResults: String) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Fetching User...", message:
                "", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            self.ckmanager.getScan(scanResult: scanResults) {
                (scan) in
                
                alertController.dismiss(animated: true, completion: nil)
                
                let date = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                
                print("year: \(year) month: \(month) day: \(day)")
                
                scan.date = date
                
                self.user.scans.append(scan)
                self.scanDetailViewController!.scan = scan
                self.present(self.scanDetailViewController!, animated: true, completion: nil)
                
                self.handler.save(completionHandler: { (success) in
                    if success {
                        
                    }
                })
                
                
            }

        }
        
    }
}
















