//
//  AboutViewController.swift
//  SAHC
//
//  Created by Michael Hari on 3/20/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(DataAccess.sharedInstance.getQuestions())

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Target-Actions
    
    @IBAction func signoutBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: End Target-Actions
    
}
