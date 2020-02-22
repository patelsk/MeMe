//
//  ViewController.swift
//  MeMeP
//
//  Created by Shyam Patel  on 11/18/19.
//  Copyright © 2019 Shyam Patel . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    var topTextDelegate = TopTextDelegate()
    var bottomTextDelegate = BottomTextDelegate()
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] =
    [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 2.5
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        topText.text = "TOP"
        topText.textAlignment = .center
        
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = .center
        
        self.topText.delegate = topTextDelegate
        self.bottomText.delegate = bottomTextDelegate
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    

    @IBAction func pickAnImage(_ sender: Any)
    {
        let pickerControl = UIImagePickerController()
        pickerControl.delegate = self
        pickerControl.sourceType = .photoLibrary
        present(pickerControl, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[.originalImage] as? UIImage
        {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    @objc func keyboardWillShow(_ notification: Notification)
    {
        if bottomText.isFirstResponder && view.frame.origin.y == 0
        {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification)
    {
        if bottomText.isFirstResponder
        {
            view.frame.origin.y = 0
        }
    }


    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeToKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

