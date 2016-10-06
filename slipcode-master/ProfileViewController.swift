//
//  ProfileViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/17/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UIViewController {
    
    //MARK: - Setup Variables
    
    @IBOutlet weak var newSlipButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slipsCollectionView: UICollectionView!
    let user = User.sharedInstance
    var slips: [Slip] = []
    
    var itemToUpdate: IndexPath? {
        didSet {
            DispatchQueue.main.async {
                if let vc = UIApplication.shared.keyWindow?.rootViewController as? MainViewController {
                    let profilevc = vc.childViewControllers[0] as! ProfileViewController
                    profilevc.slipsCollectionView.reloadItems(at: [self.itemToUpdate!])
                    print("reloaded code" + (profilevc.slips.last?.recordId.recordName ?? "none"))
                } else {
                    let vc2 = UIApplication.shared.keyWindow?.rootViewController as! LoginViewController
                    let mainvc2 = vc2.presentedViewController as! MainViewController
                    let profilevc2 = mainvc2.childViewControllers[0] as! ProfileViewController
                    profilevc2.slipsCollectionView.reloadItems(at: [self.itemToUpdate!])
                    print("reloaded code" + (profilevc2.slips.last?.recordId.recordName ?? "none"))
                }
                
            }
        }
    }
    
    func setRecordId(path: IndexPath) {
        print("setting record id")
        self.itemToUpdate = path
    }

    
    func addSlipToVC(slip: Slip) {
        self.slips.append(slip)
        user.slips.append(slip)
    }
    
    //MARK: - UIViewController Methods
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup collectionView
        let nib = UINib(nibName: "SlipsCollectionViewCell", bundle: nil)
        slipsCollectionView.register(nib, forCellWithReuseIdentifier: "SlipCell")
        slipsCollectionView.delegate = self
        slipsCollectionView.dataSource = self
        
        newSlipButton.layer.cornerRadius = 5.0
        newSlipButton.layer.masksToBounds = true
        
        newSlipButton.layer.shadowColor = UIColor.black.cgColor
        newSlipButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        newSlipButton.layer.shadowRadius = 1.5
        newSlipButton.layer.shadowOpacity = 0.6
        newSlipButton.layer.masksToBounds = false
        newSlipButton.layer.shadowPath = UIBezierPath.init(roundedRect: newSlipButton.bounds, cornerRadius: newSlipButton.layer.cornerRadius).cgPath
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = user.fullName
        self.slips = user.slips
        self.slipsCollectionView.reloadData()
    }
    
    //MARK: - Segues
    
    @IBAction func newSlipSeque(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SlipViewController") as! SlipViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func settingsSegue(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
}

//MARK: - Collection View Methods

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlipCell", for: indexPath) as! SlipsCollectionViewCell

        cell.setupSlip(slips[indexPath.row])
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath.init(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth:Float = 280 + 40;
        
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
