//
//  FriendsViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/17/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var user = User.sharedInstance
    var scans: [Scan] = []

    @IBOutlet weak var scanCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scans = user.scans ?? []
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

extension FriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scan", for: indexPath) as! ScanCollectionViewCell
        
        
        cell.scan = self.scans[indexPath.row]
        
        
        return cell
    }
    
    
}
