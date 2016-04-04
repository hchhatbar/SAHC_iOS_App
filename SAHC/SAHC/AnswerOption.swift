//
//  AnswerOption.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 4/2/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

class AnswerOption {

    
    var description: String
    var type: String
    var value: Int
    var sortOrder: Int
    
    init(description: String, type: String, value: Int, sortOrder:Int) {
        self.description = description
        self.type = type
        self.value = value
        self.sortOrder = sortOrder
    }
}