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
            hud.label.text = NSLocalizedString("Logging in...", comment: "Logging In Text for Spinner")
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), {
                
                Service.sharedInstance.authenticate(self.authCodeTxtField.text!, email: self.emailTxtField.text!, phoneNumber: self.phoneNumberTxtField.text!) { (inner: () throws -> Bool) -> Void in
                    
                    // dismiss spinner
                    dispatch_async(dispatch_get_main_queue(), {
                        hud.hideAnimated(true)
                    })
                    
                    do {
                        let success = try inner() // get result
                        
                        if success { // auth success
                            dispatch_async(dispatch_get_main_queue(), {
                                self.performSegueWithIdentifier("LoginToLandingSegue", sender: nil)
                            })
                            
                        } else {
                            
                            self.displayAlert(NSLocalizedString("Authentication Failure", comment: "Server returned auth failure"), message: NSLocalizedString("Your authcode, email and/or phone number is incorrect, please try again", comment: "Generic Auth Failture Msg"))
                            
                        }
                        
                    } catch let error {
                        
                        switch error {
                        case Service.AuthenticationError.AuthenticationAPINotReachable:
                            print(NSLocalizedString("The Internet connection appears to be offline.", comment: "Internet offline"))
                            
                            self.displayAlert(NSLocalizedString("No Internet", comment: "No Internet"), message: NSLocalizedString("The Internet connection appears to be offline.", comment: "Internet offline"))
                            
                        case Service.AuthenticationError.AuthenticationCallThrewError(let error):
                            print(error.localizedDescription)
                            
                            self.displayAlert(NSLocalizedString("Unknown Server Error", comment: "Server Error"), message: NSLocalizedString("Server is currently offline, please try again later.", comment: "Try again later"))
                        case Service.AuthenticationError.AuthenticationResponseNotOK(let httpCode):
                            print("httpCode returned from server: \(httpCode)")
                            
                            self.displayAlert(NSLocalizedString("Unknown Server Error", comment: "Server Error"), message: NSLocalizedString("Server is currently offline, please try again later.", comment: "Try again later"))
                        case Service.AuthenticationError.AuthenticationResponseMalformed(let data, let error):
                            print(error.localizedDescription)
                            print(NSString(data: data, encoding: NSUTF8StringEncoding))
                            
                            self.displayAlert(NSLocalizedString("Unknown Server Error", comment: "Server Error"), message: NSLocalizedString("Server is currently offline, please try again later.", comment: "Try again later"))
                        case Service.AuthenticationError.AuthenticationResponseUnrecognized(let json):
                            print(json)
                            
                            self.displayAlert(NSLocalizedString("Unknown Server Error", comment: "Server Error"), message: NSLocalizedString("Server is currently offline, please try again later.", comment: "Try again later"))
                        default:
                            break
                        }
                    }
                    
                }
            }) // end dispatch_async outer
        }
    }
    
    func displayAlert(title: String, message: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Okay"), style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
}
