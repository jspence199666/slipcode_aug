//
//  SlipViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/21/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit


class SlipViewController: UIViewController {
    
    var user = User.sharedInstance
    var slip = Slip()
    var accountArr: [UIButton] = []
    var imageArr: [UIButton] = []
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var whoScannedMe: UIButton!
    @IBOutlet weak var account1: UIButton!
    @IBOutlet weak var account2: UIButton!
    @IBOutlet weak var account3: UIButton!
    @IBOutlet weak var account4: UIButton!
    @IBOutlet weak var account5: UIButton!
    @IBOutlet weak var account6: UIButton!
    @IBOutlet weak var account7: UIButton!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var image5: UIButton!
    @IBOutlet weak var image6: UIButton!
    
    
    
    var segueType: Bool? {
        didSet {
            if !self.segueType! {
                whoScannedMe.isHidden = false
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        setupAccountButtons()
        setupImages()
        setupButtons()
        self.fullName.text = user.fullName
        
    }
    
    func setupImages() {
        if slip.pictures.count > 0 {
            print("setting up pictures")
            for picture in slip.pictures {
                
                let button = getButton(slip.pictures.index(of: picture)!, type: false)
                button?.titleLabel?.text = ""
                button?.setImage(picture, for: .normal)
                button?.removeTarget(self, action: #selector(imageAction), for: .touchUpInside)
                
            }
            
        } else {
            print("no pictures to set up")
        }
    }
    
    func setupAccountButtons() {
        if slip.accounts.count > 0 {
            
            let accountsArr: [String] = Array(slip.accounts.keys)
            print("setting up accounts")
            for account in accountsArr {
                print("setting up \(account)")
                switch account {
                case "facebook":
                    let fb = getButton((accountsArr.index(of: "facebook")!), type: true)
                    fb?.titleLabel?.text = "fb"
                case "twitter":
                    let t = getButton((accountsArr.index(of: "twitter")!), type: true)
                    t?.titleLabel?.text = "t"
                case "instagram":
                    let ig = getButton((accountsArr.index(of: "instagram")!), type: true)
                    ig?.titleLabel?.text = "ig"
                case "snapchat":
                    let sc = getButton((accountsArr.index(of: "snapchat")!), type: true)
                    sc?.titleLabel?.text = "sc"
                case "linkedin":
                    let li = getButton((accountsArr.index(of: "linkedin")!), type: true)
                    li?.titleLabel?.text = "li"
                case "phone":
                    let p = getButton((accountsArr.index(of: "phone")!), type: true)
                    p?.titleLabel?.text = "p"
                case "email":
                    let e = getButton((accountsArr.index(of: "email")!), type: true)
                    e?.titleLabel?.text = "e"
                default: break
                }
                
            }
            
        } else {
            print("no accounts to add")
        }

    }
    
    func getButton(_ index: Int, type: Bool) -> UIButton? {
        // true means account buttons
        if type {
            switch index {
            case 0: return account1
            case 1: return account2
            case 2: return account3
            case 3: return account4
            case 4: return account5
            case 5: return account6
            case 6: return account7
            default: return nil
            }
        } else {
            // image buttons
            switch index {
            case 0: return image1
            case 1: return image2
            case 2: return image3
            case 3: return image4
            case 4: return image5
            case 5: return image6
            default: return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.accountArr = [account1, account2, account3, account4, account5, account6, account7]
        self.imageArr = [image1, image2, image3, image4, image5, image6]
        
        accountButtonSetActions()
        imageButtonSetActions()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if slip.accounts.count > 0 && slip.pictures.count > 0 {
            //Save slip in iCloud
            
            let newSlip = Slip()
            newSlip.accounts = slip.accounts
            newSlip.bio = user.bio
            newSlip.nameOfUser = user.fullName
            newSlip.pictures = slip.pictures
            
            
            CloudKitManager.saveNewSlip(newSlip, completionHandler: {
                (recordName) in
                
                newSlip.qrCode? = recordName
                print(newSlip.qrCode)
                self.user.slips.append(newSlip)
                print(self.user.slips.count)
                self.dismiss(animated: true, completion: nil)
                print(recordName)
                
            })
            
            
            
        }
    }
    
    
    func accountButtonSetActions() {
        for account in self.accountArr {
            account.addTarget(self, action: #selector(accountAction), for: .touchUpInside)
        }
        
    }
    
    func accountAction() {
        self.performSegue(withIdentifier: "AddAccounts", sender: self)
    }
    
    func imageButtonSetActions() {
        for image  in self.imageArr {
            image.addTarget(self, action: #selector(imageAction), for: .touchUpInside)
        }
        
    }
    
    func imageAction() {
        self.performSegue(withIdentifier: "AddPictures", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAccounts" {
            let vc = segue.destination as? AddAccountsViewController
            vc?.slip = self.slip
        } else if segue.identifier == "AddPictures" {
            let vc = segue.destination as? AddPicturesViewController
            vc?.slip = self.slip
        }
    }
    
    func setupButtons() {
        
        var activeAccountButtons: [UIButton] = []
        var activeImages: [UIButton] = []
        var x = 0
        var y = 0
        print("\(slip.accounts.count) accounts: \(slip.pictures.count) pictures")
        
        for button in self.accountArr {
            
            if accountArr.index(of: button)! <= (slip.accounts.count) {
                print("setting up \(x) button")
                activeAccountButtons.append(button)
            }
            x = x + 1
        }
        
        print("\(activeAccountButtons.count) active buttons")
        
        for button in activeAccountButtons {
            button.isHidden = false
            
        }
        
        for image in self.imageArr {
            if imageArr.index(of: image)! <= (slip.pictures.count) {
                print("setting up \(y) image")
                activeImages.append(image)
            }
            y = y + 1
        }
        
        print("\(activeImages.count) active images")
        
        for image in activeImages {
            image.isHidden = false
            
        }
        
        
    }
    

    
}
