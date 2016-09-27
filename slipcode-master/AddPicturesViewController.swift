//
//  AddPicturesViewController.swift
//  slipcode-master
//
//  Created by Jeremy Spence on 9/25/16.
//  Copyright © 2016 Jeremy Spence. All rights reserved.
//

import UIKit

class AddPicturesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    var slip: Slip?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if let image = pickedImage.image {
            print("")
            print("savedImage")
            slip?.pictures.append(image)
            
        } else {
            print("image is nil")
        }
        print(slip?.pictures.count)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImage(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pickedImage.contentMode = .scaleAspectFit
            self.pickedImage.image = pickedImage
            if self.pickedImage.image != nil {
                print("set image ")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

   
}
