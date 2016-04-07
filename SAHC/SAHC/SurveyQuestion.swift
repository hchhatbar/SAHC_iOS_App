//
//  SurveyQuestion.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 4/2/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

class SurveyQuestion {
    
    var id: Int
    var abbreviation: String
    var category: String
    var type: String
    var text: String
    var label: String
    var tipText: String
    var sortOrder: Int
    var answerOptions: [AnswerOption]?
    var displayRules: [DisplayRule]?
    
    init(id: Int, abbreviation: String, category: String, type: String, text: String, label: String, tipText: String, sortOrder: Int, answerOptions: [AnswerOption]?, displayRules: [DisplayRule]?) {
        
        self.id = id
        self.abbreviation = abbreviation
        self.category = category
        self.type = type
        self.text = text
        self.label = label
        self.tipText = tipText
        self.sortOrder = sortOrder
        self.answerOptions = answerOptions
        self.displayRules = displayRules
        
    }
//    convenience init(abbreviation: String, category: String, type: String, text: String, label: String, tipText: String, sortOrder: Int, answerOptions: [AnswerOption]) {
//        
//        self.abbreviation = abbreviation
//        self.category = category
//        self.type = type
//        self.text = text
//        self.label = label
//        self.tipText = tipText
//        self.sortOrder = sortOrder
//        self.answerOptions = answerOptions
//        
//    }
    
    
}