//
//  SlipsCollectionViewCell.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/21/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import CloudKit

class SlipsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var qrView: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    
    
    var buttonArr: [UIButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonArr = [button1, button2, button3, button4, button5, button6]
        
    }
    
    func setupSlip(_ slip: Slip) {
        let recordId = slip.recordId
        
        Slip.createQRCode(recordId: recordId) { (image) in
            displayQRCodeImage(image)
        }
    
        
        var x = 0
        for (account, _) in slip.accounts {
            
            print(account)
            
            switch account {
            
            case "facebook":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "facebook100")
                buttonArr[x].setImage(button , for: UIControlState.normal)
            case "twitter":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "twitter100")
                buttonArr[x].setImage(button , for: UIControlState.normal)
            case "snapchat":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "snapchat100")
                buttonArr[x].setImage(button, for: UIControlState.normal)
            case "instagram":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "Instagram100")
                buttonArr[x].setImage(button , for: UIControlState.normal)
            case "linkedin":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "linkedin100")
                buttonArr[x].setImage(button, for: UIControlState.normal)
            case "phone":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "phone100")
                buttonArr[x].setImage(button , for: UIControlState.normal)
            case "email":
                buttonArr[x].isHidden = false
                let button = #imageLiteral(resourceName: "mail100")
                buttonArr[x].setImage(button, for: UIControlState.normal)
            default: break
                
            }
            x += 1
        }
        
        
        
    }
    
    func displayQRCodeImage(_ qrCodeImage: CIImage) {
        
        let scaleX = self.qrView.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = self.qrView.frame.size.height / qrCodeImage.extent.size.height
        let transformedImage = qrCodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        self.qrView.image = UIImage(ciImage: transformedImage)
    }

    
    func setupAddSlip() {
        
        // setup Add Slip slip
        
    }

}
