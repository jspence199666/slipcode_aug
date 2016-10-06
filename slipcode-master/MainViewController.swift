//
//  CameraViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/17/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation
import CoreGraphics

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var profileViewFrame: CGRect?
    var cameraViewFrame: CGRect?
    var friendsViewFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView.delegate = self
        setupScrollView()
    }
    
    //MARK: - Setup ScrollView
    
    func setupScrollView() {
        let profileView: ProfileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let cameraView: CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        let friendsView: FriendsViewController = FriendsViewController(nibName: "FriendsViewController", bundle: nil)
        
        self.addChildViewController(profileView)
        self.mainScrollView.addSubview(profileView.view)
        profileView.didMove(toParentViewController: self)
        
        self.profileViewFrame = profileView.view.frame
        profileViewFrame!.origin.x = self.view.frame.width * CGFloat(1)
        profileView.view.frame = profileViewFrame!
        
        self.addChildViewController(cameraView)
        self.mainScrollView.addSubview(cameraView.view)
        cameraView.didMove(toParentViewController: self)
        
        self.cameraViewFrame = cameraView.view.frame
        cameraViewFrame!.origin.x = self.view.frame.width * CGFloat(2)
        cameraView.view.frame = cameraViewFrame!
        
        self.addChildViewController(friendsView)
        self.mainScrollView.addSubview(friendsView.view)
        friendsView.didMove(toParentViewController: self)
        
        self.friendsViewFrame = friendsView.view.frame
        friendsViewFrame!.origin.x = self.view.frame.width * CGFloat(0)
        friendsView.view.frame = friendsViewFrame!
        
        
        self.mainScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        let offsetX: CGFloat = self.mainScrollView.contentSize.width / 3
        let offsetY: CGFloat = 0
        let offset: CGPoint = CGPoint(x: offsetX, y: offsetY)
        self.mainScrollView.setContentOffset(offset, animated: false)
    }
    

}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll view did scroll")
        if scrollView.bounds.intersects(cameraViewFrame!) {
            print("camera view loaded")
            self.tabBar.selectedItem = self.tabBar.items![2]
        } else if scrollView.bounds.intersects(profileViewFrame!) {
            print("profile view loaded")
            self.tabBar.selectedItem = self.tabBar.items![1]
        } else if scrollView.bounds.intersects(friendsViewFrame!) {
            print("friends view loaded")
            self.tabBar.selectedItem = self.tabBar.items![0]
        }
        
        
        
    }
    
}
