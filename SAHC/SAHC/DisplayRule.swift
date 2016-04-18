//
//  DisplayRule.swift
//  SAHC
//
//  Created by Michael Hari on 4/4/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

class DisplayRule {
    
    var property: String
    var type: String
    var operation: String
    var value: String
    
    init(property: String, type: String, operation: String, value: String) {
        self.property = property
        self.type = type
        self.operation = operation
        self.value = value
    }

}
