//
//  IDScannerViewController.swift
//  Moi
//
//  Created by Cole Fox on 11/1/17.
//  Copyright © 2017 Ty Udy. All rights reserved.
//

import Foundation
import UIKit
import MicroBlink

class IDScannerViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var touchLabel: UILabel!
    
    //MARK: Actions
    
    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
        screenTouched()
    }
    //MARK: VC lifecycle
    override func viewDidLoad() {
        self.view.isUserInteractionEnabled = true
        
    }
    
    //MARK: Member Funcs
    func screenTouched() {
        print("touched screen")
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.touchLabel.alpha = 0.0
        }, completion: nil)
        
        /** Instantiate the scanning coordinator */
        let error: NSErrorPointer = nil
        let coordinator = self.coordinatorWithError(error: error)
        
        /** If scanning isn't supported, present an error */
        if coordinator == nil {
            let messageString: String = (error!.pointee?.localizedDescription) ?? ""
            UIAlertView(title: "Warning", message: messageString, delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }
        
        /** Allocate and present the scanning view controller */
        let scanningViewController: UIViewController = PPViewControllerFactory.cameraViewController(with: self as! PPScanningDelegate, coordinator: coordinator!, error: nil)
        
        /** You can use other presentation methods as well */
        self.present(scanningViewController, animated: true, completion: nil)
        
    }
    
    
    func coordinatorWithError(error: NSErrorPointer) -> PPCameraCoordinator? {
        
        /** 0. Check if scanning is supported */
        
        if (PPCameraCoordinator.isScanningUnsupported(for: PPCameraType.back, error: error)) {
            return nil;
        }
        
        
        /** 1. Initialize the Scanning settings */
        
        // Initialize the scanner settings object. This initialize settings with all default values.
        let settings: PPSettings = PPSettings()
        
        
        /** 2. Setup the license key */
        
        // Visit www.microblink.com to get the license key for your app
        settings.licenseSettings.licenseKey = "HAHBUO7F-QUOJ32PB-XGJSFKAS-HD33JC46-YLGVLJSS-JLYNL2TO-T6FG7U66-O4SPSWYZ"
        
        
        /**
         * 3. Set up what is being scanned. See detailed guides for specific use cases.
         * Remove undesired recognizers (added below) for optimal performance.
         */
        
        do { // Remove this if you're not using MRTD recognition
            
            // To specify we want to perform MRTD (machine readable travel document) recognition, initialize the MRTD recognizer settings
            let mrtdRecognizerSettings = PPMrtdRecognizerSettings()
            
            /** You can modify the properties of mrtdRecognizerSettings to suit your use-case */
            
            // tell the library to get full image of the document. Setting this to YES makes sense just if
            // settings.metadataSettings.dewarpedImage = YES, otherwise it wastes CPU time.
            mrtdRecognizerSettings.dewarpFullDocument = false;
            
            // Add MRTD Recognizer setting to a list of used recognizer settings
            settings.scanSettings.add(mrtdRecognizerSettings)
        }
        
        do { // Remove this if you're not using USDL recognition
            
            // To specify we want to perform USDL (US Driver's license) recognition, initialize the USDL recognizer settings
            let usdlRecognizerSettings = PPUsdlRecognizerSettings()
            
            /** You can modify the properties of usdlRecognizerSettings to suit your use-case */
            
            // Add USDL Recognizer setting to a list of used recognizer settings
            settings.scanSettings.add(usdlRecognizerSettings)
        }
        
        /** 4. Initialize the Scanning Coordinator object */
        
        let coordinator: PPCameraCoordinator = PPCameraCoordinator(settings: settings)
        
        return coordinator
    }
}
