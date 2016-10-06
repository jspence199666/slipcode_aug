//
//  SlipViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/21/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import SimpleAlert

class SlipViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user = User.sharedInstance
    var slip = Slip()
    let handler = HandleUser()
    let manager = CloudKitManager()
    let profileVC = ProfileViewController()
    
    var accountButtonArr: [UIButton] = []
    var imageButtonArr: [UIButton] = []
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bioTextField: UITextField!
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        setupAccountButtons()
        setupImages()
        setupButtons()
        
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
                    fb?.setImage(#imageLiteral(resourceName: "facebook100"), for: .normal); fb?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "twitter":
                    let t = getButton((accountsArr.index(of: "twitter")!), type: true)
                    t?.setImage(#imageLiteral(resourceName: "twitter100"), for: .normal); t?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "instagram":
                    let ig = getButton((accountsArr.index(of: "instagram")!), type: true)
                    ig?.setImage(#imageLiteral(resourceName: "Instagram100"), for: .normal); ig?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "snapchat":
                    let sc = getButton((accountsArr.index(of: "snapchat")!), type: true)
                    sc?.setImage(#imageLiteral(resourceName: "snapchat100"), for: .normal); sc?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "linkedin":
                    let li = getButton((accountsArr.index(of: "linkedin")!), type: true)
                    li?.setImage(#imageLiteral(resourceName: "linkedin100"), for: .normal); li?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "phone":
                    let p = getButton((accountsArr.index(of: "phone")!), type: true)
                    p?.setImage(#imageLiteral(resourceName: "phone100"), for: .normal); p?.removeTarget(nil, action: nil, for: .touchUpInside)
                case "email":
                    let e = getButton((accountsArr.index(of: "email")!), type: true)
                    e?.setImage(#imageLiteral(resourceName: "mail100"), for: .normal); e?.removeTarget(nil, action: nil, for: .touchUpInside)
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
        
        imagePicker.delegate = self
        
        self.bioTextField.layer.cornerRadius = 5.0
        self.containerView.layer.cornerRadius = 5.0
        
        self.accountButtonArr = [account1, account2, account3, account4, account5, account6, account7]
        self.imageButtonArr = [image1, image2, image3, image4, image5, image6]
        
        for button in imageButtonArr {
            button.contentMode = UIViewContentMode.scaleAspectFit
        }
        
        print("setting up buttons")
        accountButtonSetActions()
        imageButtonSetActions()
        
        var frameRect: CGRect = self.bioTextField.frame
        frameRect.size.height = 60
        self.bioTextField.frame = frameRect
    }
    
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: AnyObject) {
        if slip.accounts.count > 0 && slip.pictures.count > 0 {
            print("saving slip")
            
            
            let newSlip = Slip()
            newSlip.accounts = slip.accounts
            newSlip.nameOfUser = user.fullName
            newSlip.pictures = slip.pictures
            newSlip.bio = bioTextField.text ?? ""
            DispatchQueue.main.async {
                self.profileVC.addSlipToVC(slip: newSlip)
                self.dismiss(animated: true, completion: nil)
            }
            
            
            self.handler.save(completionHandler: { (success) in
                if success {
                    self.manager.saveSlip(slip: newSlip, completionHandler: { (recordId) in
                        print("saved to iCloud")
                            
                        self.user.slips[self.user.slips.count - 1].recordId = recordId
                        let profileVC = ProfileViewController()
                        profileVC.itemToUpdate = IndexPath(item: (self.user.slips.count - 1), section: 0)
                            
                        self.handler.save(completionHandler: { (success) in
                            if success {print("saved record")}
                        })
                            
                            
                    })
                        
                }
            })
            
            
            
           
            
            
        }
    }
    
    
    func accountButtonSetActions() {
        for account in self.accountButtonArr {
            account.addTarget(self, action: #selector(accountAction), for: .touchUpInside)
        }
        
    }
    
    
    func accountAction() {
        let viewController = AddAccountsViewController()
        let alert = AlertController(view: viewController.view, style: .actionSheet)
        alert.addAction(AlertAction(title: "Cancel", style: .cancel))
        alert.addAction(AlertAction(title: "Save", style: .default) { action in
            
            var accountsToAddDict: [String: String] = [:]
            let accountsToAdd = viewController.accountsToAdd
            
            for account in accountsToAdd {
                accountsToAddDict[account] = self.user.accounts[account]
                print(account + "!!!!!!!!!!!!")
            }
            
            self.slip.accounts = accountsToAddDict
            
            self.setupButtons()
            self.setupAccountButtons()
            
            
        })
        alert.addAction(AlertAction(title: "Add New Accounts", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imageButtonSetActions() {
        for image in self.imageButtonArr {
            image.addTarget(self, action: #selector(imageAction), for: .touchUpInside)
        }
        
    }
    
    func imageAction() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let numPics = self.slip.pictures.count
            
            getButton(numPics-1, type: false)?.setImage(pickedImage, for: .normal)
            self.slip.pictures.append(pickedImage)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func setupButtons() {
        print("setting up what buttons show")
        var activeAccountButtons: [UIButton] = []
        var activeImages: [UIButton] = []
        var x = 0
        var y = 0
        print("\(slip.accounts.count) accounts: \(slip.pictures.count) pictures")
        
        for button in self.accountButtonArr {
            
            if accountButtonArr.index(of: button)! <= (slip.accounts.count) {
                print("setting up \(x) button")
                activeAccountButtons.append(button)
            }
            x = x + 1
        }
        
        print("\(activeAccountButtons.count) active buttons")
        
        for button in activeAccountButtons {
            button.isHidden = false
            
        }
        
        for image in self.imageButtonArr {
            if imageButtonArr.index(of: image)! <= (slip.pictures.count) {
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













