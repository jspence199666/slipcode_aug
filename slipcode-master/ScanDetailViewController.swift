//
//  ScanDetailViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/26/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import MapKit

class ScanDetailViewController: UIViewController {

    var scan: Scan?
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    
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
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fullName.text = self.scan?.name
        self.bio.text = self.scan?.bio
        self.date.text = "Date"//self.scan!.date
        
        var imageArr: [UIImageView] = [image1, image2, image3, image4, image5, image6]
        var buttonArr: [UIButton] = [button1, button2, button3, button4, button5, button6, button7]
        
        var i = 0
        for image in self.scan!.pictures {
            imageArr[i].image = image
            i += 1
        }
        
        var h = 0
        for (key, _) in self.scan!.accounts {
            switch key {
            case "facebook":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "fb"
                buttonArr[h].addTarget(self, action: #selector(addFB), for: .touchUpInside)
            case "twitter":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "tw"
                buttonArr[h].addTarget(self, action: #selector(addTW), for: .touchUpInside)
            case "instagram":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "ig"
                buttonArr[h].addTarget(self, action: #selector(addSC), for: .touchUpInside)
            case "snapchat":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "sc"
                buttonArr[h].addTarget(self, action: #selector(addIG), for: .touchUpInside)
            case "linkedin":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "li"
                buttonArr[h].addTarget(self, action: #selector(addLI), for: .touchUpInside)
            case "phone":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "ph"
            case "email":
                buttonArr[h].isHidden = false
                buttonArr[h].titleLabel?.text = "em"
            default: break
            }
            h += 1
        }
        
        
        // setup map
        
        
    }
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    


}
