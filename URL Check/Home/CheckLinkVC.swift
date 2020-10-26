//
//  CheckLinkVC.swift
//  URL Check
//
//  Created by Vinayak Sharma on 25/10/20.
//

import UIKit

class CheckLinkVC: UIViewController {
    
    
    @IBOutlet weak var checkGoogleSafeView: UIView!
    
    @IBOutlet weak var urlDestinationView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        
        case 0:
            checkGoogleSafeView.isHidden = true
            urlDestinationView.isHidden = false

        case 1:
            checkGoogleSafeView.isHidden = false
            urlDestinationView.isHidden = true

        default:
            break
        }
    }
}
