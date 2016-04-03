//
//  LoginViewController.swift
//  SAHC
//
//  Created by Michael Hari on 3/24/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var authCodeTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var phoneNumberTxtField: UITextField!
    
    @IBAction func signInBtnPressed(sender: AnyObject) {
        
        // TODO: validate fields are validate inputs
        if self.authCodeTxtField.text != nil && self.emailTxtField.text != nil && self.phoneNumberTxtField.text != nil {
            
            let hud: MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.AnnularDeterminate
            hud.label.text = "Logging in..."
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), {
                
                Service.sharedInstance.authenticate(self.authCodeTxtField.text!, email: self.emailTxtField.text!, phoneNumber: self.phoneNumberTxtField.text!) { (inner: () throws -> Bool) -> Void in
                    do {
                        let success = try inner()
                        if success {
                            dispatch_async(dispatch_get_main_queue(), {
                                hud.hideAnimated(true)
                                self.performSegueWithIdentifier("LoginToLandingSegue", sender: nil)
                            })
                            
                        } else {
                            // TODO: show failure to login
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }) // end dispatch_async outer
        }
    }
    
}
