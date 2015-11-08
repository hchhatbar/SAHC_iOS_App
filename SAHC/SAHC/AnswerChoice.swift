//
//  AnswerChoice.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 11/5/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(AnswerChoice)
class AnswerChoice: NSManagedObject {

    @NSManaged var answer_description: String
    @NSManaged var type: String
    @NSManaged var value: NSNumber
    @NSManaged var sort_order: NSNumber
    @NSManaged var abbreviation: String
    @NSManaged var href: String
    @NSManaged var question: Question

}
