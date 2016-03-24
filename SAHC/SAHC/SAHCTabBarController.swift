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
        
        // http://stackoverflow.com/questions/30041127/ios-8-tab-bar-item-background-colour
        // add the white selection and orange 
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor(red: 245.0/255, green: 132.0/255, blue: 30.0/255, alpha: 1.0), size: CGSizeMake(tabBar.frame.width/4, tabBar.frame.height))
        // default to second tab "HRA"
        self.selectedIndex = 1
    }
    
}

// http://stackoverflow.com/questions/30041127/ios-8-tab-bar-item-background-colour
extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
