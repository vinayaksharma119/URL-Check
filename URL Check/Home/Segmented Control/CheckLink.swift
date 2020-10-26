//
//  CheckLink.swift
//  URL Check
//
//  Created by Vinayak Sharma on 25/10/20.
//

import UIKit

class CheckLink: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var checkLinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkLinkButton.isEnabled == false {checkLinkButton.alpha = 0.5}
        checkLinkButton.layer.cornerRadius = 20
        linkTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
}

extension CheckLink: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if linkTextField.text == "" {
            checkLinkButton.isEnabled = false
            checkLinkButton.alpha = 0.5
        } else {
            checkLinkButton.isEnabled = true
            checkLinkButton.alpha = 1
        }
    }
}
