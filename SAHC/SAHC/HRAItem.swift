//
//  HRAItem.swift
//  SAHC
//
//  Created by Michael Hari on 3/21/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import Foundation
import UIKit

class HRAItem: NSObject {
    
    let image: UIImage
    let itemName: String
    var progress: Float
    
    init(image: UIImage, itemName: String, progress: Float = 0.0) {
        
        self.image = image
        self.itemName = itemName
        self.progress = progress
        
    }
}
