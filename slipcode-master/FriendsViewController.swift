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
    var scans: [Scan]?
    
    
    @IBOutlet weak var scanCollectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        scans = user.scans
        self.scanCollectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        scans = user.scans
        print(scans?.count ?? "nil")
        
        let nib = UINib(nibName: "ScanCollectionViewCell", bundle: nil)
        scanCollectionView.register(nib, forCellWithReuseIdentifier: "scan")
        scanCollectionView.delegate = self
        scanCollectionView.dataSource = self
        
        let width = ((UIScreen.main.bounds.width - 32.0) / 3)
        let layout = scanCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 1.5*width)
        
    }
    
}

extension FriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scans!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scan", for: indexPath) as! ScanCollectionViewCell
        print("setting up cell")
        
        let scan = self.scans?[indexPath.row]
        
        cell.setupCell(scan: scan!)
        print(self.scans?[indexPath.row].name)
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 0.6
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath.init(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScanDetailViewController") as! ScanDetailViewController
        viewController.scan = scans![indexPath.row]
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
