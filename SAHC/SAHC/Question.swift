//
//  Question.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(Question)
class Question: NSManagedObject {

    @NSManaged var questionId: String
    @NSManaged var questionText: String
    @NSManaged var questionType: String
    @NSManaged var categoryId: NSNumber
    @NSManaged var tipText: String
    @NSManaged var helper: String
    @NSManaged var answer: NSOrderedSet?
    //@NSManaged var answer: [AnswerChoice]
    
    // Standard Core Data init method.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }


}
