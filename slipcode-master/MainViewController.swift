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

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
    }
    
    //MARK: - Setup ScrollView
    
    func setupScrollView() {
        let profileView: ProfileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let cameraView: CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        let friendsView: FriendsViewController = FriendsViewController(nibName: "FriendsViewController", bundle: nil)
        
        let subViews = [cameraView, profileView, friendsView]
        
        for subView in subViews {
            self.addChildViewController(subView)
            self.mainScrollView.addSubview(subView.view)
            subView.didMove(toParentViewController: self)
            
            var viewFrame: CGRect = subView.view.frame
            viewFrame.origin.x = self.view.frame.width * CGFloat(subViews.index(of: subView)!.hashValue)
            subView.view.frame = viewFrame
            
        }
        
        self.mainScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        let offsetX: CGFloat = self.mainScrollView.contentSize.width / 3
        let offsetY: CGFloat = 0
        let offset: CGPoint = CGPoint(x: offsetX, y: offsetY)
        self.mainScrollView.setContentOffset(offset, animated: false)
    }
    

    

}
