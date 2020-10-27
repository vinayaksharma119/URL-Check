//
//  ExpandLinkVC.swift
//  URL Check
//
//  Created by Vinayak Sharma on 26/10/20.
//

import UIKit

class ExpandLinkVC: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var expandLinkButton: LoadingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandLinkButton.layer.cornerRadius = 20
        if expandLinkButton.isEnabled == false {expandLinkButton.alpha = 0.5}
        linkTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func expandLinkButtonClicked(_ sender: Any) {
        expandLinkButton.alpha = 0.5
        expandLinkButton.showLoading()
        expandURL()
    }
    
    func expandURL (){
        let url = URL(string: linkTextField.text!)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "HEAD"

        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let expandedURL = urlResponse?.url?.absoluteString
            
            DispatchQueue.main.async {
                self.expandLinkButton.hideLoading()
                self.expandLinkButton.alpha = 1
                self.presentAlert(withTitle: "It goes to \n", message: expandedURL ?? " Error not a url")
            }
        }.resume()
    }
    
}

extension ExpandLinkVC: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if linkTextField.text == "" {
            expandLinkButton.isEnabled = false
            expandLinkButton.alpha = 0.5
        } else {
            expandLinkButton.isEnabled = true
            expandLinkButton.alpha = 1
        }
    }
}

