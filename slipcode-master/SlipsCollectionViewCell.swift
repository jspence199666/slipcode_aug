//
//  SlipsCollectionViewCell.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/21/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class SlipsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var qrView: UIImageView!
    
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var snapchat: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var linkedin: UIButton!
    @IBOutlet weak var email: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupSlip(_ slip: Slip) {
        
        createQRCode(slip.qrCode!)
        
        for (account, _) in slip.accounts {
            
            print(account)
            
            switch account {
            
            case "facebook": facebook.isHidden = false
            case "twitter": twitter.isHidden = false
            case "snapchat": snapchat.isHidden = false
            case "instagram": instagram.isHidden = false
            case "linkedin": linkedin.isHidden = false
            case "phone": phone.isHidden = false
            case "email": email.isHidden = false
            default: break
                
            }
            
        }
        
    }
    
    fileprivate func createQRCode(_ recordID: String) {
        var newFilter: CIImage?
        
        let dataForQRCode = (recordID)
        let data = dataForQRCode.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        newFilter =  filter?.outputImage
        
        if newFilter != nil {
            displayQRCodeImage(newFilter!)
        } else {
            print("Error making QR from message")
        }
        
    }
    
    fileprivate func displayQRCodeImage(_ qrCodeImage: CIImage) {
        let scaleX = self.qrView!.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = self.qrView!.frame.size.height / qrCodeImage.extent.size.height
        let transformedImage = qrCodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        self.qrView!.image = UIImage(ciImage: transformedImage)
    }

    
    func setupAddSlip() {
        
        
        
    }

}
