//
//  LoadDataViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/28/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class LoadDataViewController: UIViewController {

    let manager = CloudKitManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.main.async {
            self.manager.loadUser { (success) in
                if success {
                    self.manager.loadSlipRecords(completionHandler: { (success) in
                        if success {
                            print("loaded slips")
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            self.performSegue(withIdentifier: "loadedData", sender: self)
                        }
                    })
                }
            }
        }
        
        
        
    }
    
    
 
}
