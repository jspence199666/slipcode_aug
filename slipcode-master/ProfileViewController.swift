//
//  ProfileViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/17/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var slipsCollectionView: UICollectionView!
    let user = User.sharedInstance
    var slips: [Slip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let nib = UINib(nibName: "SlipsCollectionViewCell", bundle: nil)
        slipsCollectionView.register(nib, forCellWithReuseIdentifier: "SlipCell")
        slipsCollectionView.delegate = self
        slipsCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(user.slips.count)
        self.slips = user.slips
        print(self.slips.count)
        self.slipsCollectionView.reloadData()
        
    }
    
    @IBAction func newSlipSeque(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SlipViewController") as! SlipViewController
        viewController.segueType = true
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func settingsSegue(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.slips.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlipCell", for: indexPath) as! SlipsCollectionViewCell
        
        if indexPath.row == 0 {
            cell.setupAddSlip()
        } else {
            cell.setupSlip(slips[indexPath.row - 1])
        }
        
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth:Float = 225 + 70;
        
        let currentOffSet:Float = Float(scrollView.contentOffset.x)
        
        let targetOffSet:Float = Float(targetContentOffset.pointee.x)
        
        var newTargetOffset:Float = 0
        
        if(targetOffSet > currentOffSet){
            newTargetOffset = ceilf(currentOffSet / pageWidth) * pageWidth
        }else{
            newTargetOffset = floorf(currentOffSet / pageWidth) * pageWidth
        }
        
        if(newTargetOffset < 0){
            newTargetOffset = 0;
        }else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffSet)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: 0), animated: true)
    }
    
    
    
    
}
