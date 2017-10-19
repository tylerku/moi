//
//  FacialScannerViewController.swift
//  Moi
//
//  Created by Ty Udy on 10/11/17.
//  Copyright © 2017 Ty Udy. All rights reserved.
//

import Foundation
import Vision
import UIKit
import AVFoundation

class FacialScannerViewController: UIViewController {
    
    
    
    @IBOutlet weak var cameraView: UIView!
    private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        guard
            let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let input = try? AVCaptureDeviceInput(device: backCamera)
            else { return session }
        session.addInput(input)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make the camera appear on the screen
        self.cameraView.layer.addSublayer(self.cameraLayer)
        
        //begin session
        self.captureSession.startRunning()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // make sure the layer is the correct size
        self.cameraLayer.frame = self.cameraView?.bounds ?? .zero
    }
    
}
