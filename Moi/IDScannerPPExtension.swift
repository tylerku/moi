//
//  IDScannerPPExtension.swift
//  Moi
//
//  Created by Cole Fox on 11/16/17.
//  Copyright © 2017 Ty Udy. All rights reserved.
//

import Foundation
import UIKit
import MicroBlink

extension IDScannerViewController : PPScanningDelegate {
    func scanningViewControllerUnauthorizedCamera(_ scanningViewController: UIViewController & PPScanningViewController) {
        // Add any logic which handles UI when app user doesn't allow usage of the phone's camera

    }
    
    func scanningViewController(_ scanningViewController: UIViewController & PPScanningViewController, didFindError error: Error) {
        // Can be ignored. See description of the method

    }
    
    func scanningViewControllerDidClose(_ scanningViewController: UIViewController & PPScanningViewController) {
        // As scanning view controller is presented full screen and modally, dismiss it
        self.dismiss(animated: true, completion: nil)
    }
    
    func scanningViewController(_ scanningViewController: (UIViewController & PPScanningViewController)?, didOutputResults results: [PPRecognizerResult]) {
        let scanConroller : PPScanningViewController = scanningViewController as! PPScanningViewController
        
        // Here you process scanning results. Scanning results are given in the array of PPRecognizerResult objects.
        
        // first, pause scanning until we process all the results
        scanConroller.pauseScanning()
        
        var message : String = ""
        var title : String = ""
        
        // Collect data from the result
        for result in results {
            if(result is PPMrtdRecognizerResult) {
                let mrtdResult : PPMrtdRecognizerResult = result as! PPMrtdRecognizerResult
                title="MRTD"
                message=mrtdResult.description
            }
            if(result is PPUsdlRecognizerResult) {
                let usdlResult : PPUsdlRecognizerResult = result as! PPUsdlRecognizerResult
                title="USDL"
                message=usdlResult.description
            }
        }
        
        //present the alert view with scanned results
        let alertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismiss(animated: true, completion: nil)
    }
}
