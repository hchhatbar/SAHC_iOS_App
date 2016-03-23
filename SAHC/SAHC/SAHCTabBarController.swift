//
//  SAHCTabBarController.swift
//  SAHC
//
//  Created by Michael Hari on 3/22/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import UIKit

class SAHCTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // default to second tab "HRA"
        self.selectedIndex = 1
    }
    
}
