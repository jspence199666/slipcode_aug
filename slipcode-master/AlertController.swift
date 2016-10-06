//
//  AlertController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 10/4/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit
import SimpleAlert

class CustomAlertController: AlertController {
    override func addTextFieldWithConfigurationHandler(_ configurationHandler: ((UITextField?) -> Void)? = nil) {
        super.addTextFieldWithConfigurationHandler() { textField in
            textField?.frame.size.height = 50
            textField?.backgroundColor = nil
            textField?.layer.borderColor = nil
            textField?.layer.borderWidth = 20
            
            configurationHandler?(textField)
        }
    }
    
    override func configureButton(_ style :AlertAction.Style, forButton button: UIButton) {
        super.configureButton(style, forButton: button)
        
        switch style {
        case .ok:
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitleColor(UIColor.gray, for: UIControlState())
        case .cancel:
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(UIColor.white, for: UIControlState())
        case .default:
            button.setTitleColor(UIColor.lightGray, for: UIControlState())
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configContentView = { view in
            if let view = view as? AlertContentView {
                view.titleLabel.textColor = UIColor.lightGray
                view.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
                view.messageLabel.textColor = UIColor.lightGray
                view.messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
                view.textBackgroundView.layer.cornerRadius = 3.0
                view.textBackgroundView.clipsToBounds = true
            }
        }
    }
}
