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
    
    var scan: Scan?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = scan?.name
        
    }

}
