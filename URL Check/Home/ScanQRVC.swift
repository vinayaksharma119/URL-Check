//
//  ScanQRVC.swift
//  URL Check
//
//  Created by Vinayak Sharma on 23/10/20.
//

import UIKit
import AVFoundation

class ScanQRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var squareImage: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var flashLightButton: UIButton!
    
    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    var checkFlashLight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        flashLightButton.layer.cornerRadius = 20
        prepareCapture()
    }
    
    func prepareCapture() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            } catch {
            print(error)
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubviewToFront(squareImage)
        self.view.bringSubviewToFront(buttonView)
        session.startRunning()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    if qrCodeContentIsURL(object.stringValue!) {
                        GoogleSafeBrowsingAPI.checkURLSafe(object.stringValue!) { (result) in
                            if result! {
                                self.presentAlert(withTitle: "Passed", message: "\(object.stringValue!) \n Looks safe")
                                } else {
                                    self.presentAlert(withTitle: "Failed", message: "\(object.stringValue!) \n looks unsafe")
                                }
                        }
                    }
                    else {
                        self.presentAlert(withTitle: "Try again", message: "It is not a URL")
                    }
                
                }
            }
        }
    }
    
    func qrCodeContentIsURL(_ source:String) -> Bool {
        if let url = URL(string: source) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleFlash(_ sender: Any) {
        if checkFlashLight == false {
            toggleTorch(on: true)
        }
        else if checkFlashLight == true {
            toggleTorch(on: false)
        }
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                checkFlashLight = true
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                    flashLightButton.backgroundColor = .white
                    flashLightButton.tintColor = .blue
                } else {
                    checkFlashLight = false
                    device.torchMode = .off
                    flashLightButton.backgroundColor = .clear
                    flashLightButton.tintColor = .white
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
