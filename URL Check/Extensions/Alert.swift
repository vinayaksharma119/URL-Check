//
//  Alert.swift
//  URL Check
//
//  Created by Vinayak Sharma on 24/10/20.
//

import UIKit

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let actionButton = UIAlertAction(title: "Ok", style: .default) { action in
        self.dismiss(animated: true)
    }
    alertController.addAction(actionButton)
    self.present(alertController, animated: true, completion: nil)
  }
}
