//
//  BottomTextDelegate.swift
//  MeMeP
//
//  Created by Shyam Patel  on 11/19/19.
//  Copyright © 2019 Shyam Patel . All rights reserved.
//

import Foundation
import UIKit

class BottomTextDelegate: NSObject, UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.text = ""
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
