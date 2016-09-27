//
//  Slip.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/24/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

open class Slip {
    
    
    var qrCode: String?
    var bio: String?
    var accounts: [String: String] = [:]
    var pictures: [UIImage] = []
    var scannedMe: [ScannedMe]?
    var nameOfUser: String?
    


    
}
