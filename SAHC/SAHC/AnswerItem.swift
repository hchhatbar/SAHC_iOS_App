//
//  AnswerItem.swift
//  SAHC
//
//  Created by Michael Hari on 3/30/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import Foundation

class AnswerItem: NSObject {
    
    enum SelectionButtonType {
        case CheckMark, Radio
    }
    
    var answerValue: String
    var selected: Bool = false
    var buttonType: SelectionButtonType = SelectionButtonType.Radio
    
    init(answerValue: String) {
        self.answerValue = answerValue
    }
}