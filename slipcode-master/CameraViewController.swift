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
    
    //MARK: - Setup Variables
    var user = User.sharedInstance
    let handler = HandleUser()
    let scanner = QRCode()
    let ckmanager = CloudKitManager()
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.prepareScan(cameraView) { stringValue -> () in
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ckmanager.getScan(scanResult: scanResults) {
            (scan) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            self.user.scans.append(scan)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ScanDetailViewController") as! ScanDetailViewController
            viewController.scan = scan
            self.present(viewController, animated: true, completion: nil)
            
            self.handler.save(completionHandler: { (success) in
                if success {
                    
                }
            })
            
            
        }

    }
}
















