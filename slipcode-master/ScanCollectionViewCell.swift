//
//  ScanCollectionViewCell.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/27/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class ScanCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(scan: Scan) {
        let hbounds = nameLabel.frame.height
        print(hbounds)
        print(scan.name)
        nameLabel.text = scan.name
        imageView.image = scan.pictures[0]
    }

}
