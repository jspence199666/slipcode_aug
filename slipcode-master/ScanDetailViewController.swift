//
//  ScanDetailViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/26/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
//import MapKit

class ScanDetailViewController: UIViewController {

    var scan: Scan?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var outlineView: UIView!
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    
    //@IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        outlineView.layer.cornerRadius = 5.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fullName.text = self.scan?.name
        self.bio.text = self.scan?.bio
        print("PICTURES: \(self.scan?.pictures.count)")
        
        let date = self.scan?.date
        if date != nil {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date!)
            let month = calendar.component(.month, from: date!)
            let day = calendar.component(.day, from: date!)
            self.date.text = "\(month) \(day), \(year)"
        }
        
        
        setupButtons()
        setupMap()
        
    }
    

    
    func setupButtons() {
        let buttonArr: [UIButton] = [button1, button2, button3, button4, button5, button6, button7]
        var h = 0
        for (key, _) in self.scan!.accounts {
            switch key {
            case "facebook":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "facebook150"), for: .normal)
                buttonArr[h].addTarget(self, action: #selector(addFB), for: .touchUpInside)
            case "twitter":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "twitter150"), for: .normal)
                buttonArr[h].addTarget(self, action: #selector(addTW), for: .touchUpInside)
            case "instagram":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "Instagram150"), for: .normal)
                buttonArr[h].addTarget(self, action: #selector(addSC), for: .touchUpInside)
            case "snapchat":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "snapchat150"), for: .normal)
                buttonArr[h].addTarget(self, action: #selector(addIG), for: .touchUpInside)
            case "linkedin":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "linkedin150"), for: .normal)
                buttonArr[h].addTarget(self, action: #selector(addLI), for: .touchUpInside)
            case "phone":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "phone150"), for: .normal)
            case "email":
                buttonArr[h].isHidden = false
                buttonArr[h].setImage(#imageLiteral(resourceName: "mail150"), for: .normal)
            default: break
            }
            h += 1
        }
    }
    
    func setupMap() {
        //TODO: - Setup Map
    }
    
    //MARK: - add Button Actions
    
    func addFB() {
        for (x, y) in self.scan!.accounts {
            if x == "facebook" {
                UIApplication.shared.openURL(URL(string: "http://www.facebook.com/\(y)")!)
            }
        }
    }
    func addSC() {
        for (x, y) in self.scan!.accounts {
            if x == "snapchat" {
                UIApplication.shared.openURL(URL(string: "http://www.snapchat.com/add/\(y)")!)
            }
        }
    }
    func addTW() {
        for (x, y) in self.scan!.accounts {
            if x == "twitter" {
                UIApplication.shared.openURL(URL(string: "http://www.twitter.com/\(y)")!)
            }
        }
    }
    func addIG() {
        for (x, y) in self.scan!.accounts {
            if x == "instagram" {
                UIApplication.shared.openURL(URL(string: "http://www.instagram.com/\(y)")!)
            }
        }
    }
    func addLI() {
        for (x, y) in self.scan!.accounts {
            if x == "linkedin" {
                UIApplication.shared.openURL(URL(string: "http://www.linkedin.com/in/\(y)")!)
            }
        }
    }

    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    


}

extension ScanDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.scan!.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pic", for: indexPath) as! PictureCollectionViewCell
        
        cell.imageView.image = self.scan!.pictures[indexPath.row]
        return cell
    }
    
}

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
}
