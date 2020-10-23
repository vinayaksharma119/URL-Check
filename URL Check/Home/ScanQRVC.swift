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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
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
                    
                }
            }
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
    }
    
    @IBAction func toggleFlash(_ sender: Any) {
    }
    
    
}
