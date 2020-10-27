//
//  CheckLinkVC.swift
//  URL Check
//
//  Created by Vinayak Sharma on 25/10/20.
//

import UIKit

class CheckLinkVC: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var checkLinkButton: LoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkLinkButton.isEnabled == false {checkLinkButton.alpha = 0.5}
        checkLinkButton.layer.cornerRadius = 20
        linkTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func checkLinkButtonClicked(_ sender: Any) {
        checkLinkButton.showLoading()
        GoogleSafeBrowsingAPI.checkURLSafe(linkTextField.text!) { (result) in
            
            if self.textContentIsURL(self.linkTextField.text!) {
                if result! {
                    self.checkLinkButton.hideLoading()
                    self.presentAlert(withTitle: "Passed", message: "\(self.linkTextField.text!) \n is safe to visit")
                    }
                else {
                    self.checkLinkButton.hideLoading()
                    self.presentAlert(withTitle: "Failed", message: "\(self.linkTextField.text!) \n is unsafe to visit")
                    }
            }
            else {
                self.checkLinkButton.hideLoading()
                self.presentAlert(withTitle: "Please try again", message: "Please enter a url")
            }
        }
    }
    
    func textContentIsURL(_ source:String) -> Bool {
        if let url = URL(string: source) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

extension CheckLinkVC: UITextFieldDelegate{
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
