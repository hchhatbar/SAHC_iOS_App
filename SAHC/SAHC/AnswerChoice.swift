//
//  AnswerChoice.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(AnswerChoice)
class AnswerChoice: NSManagedObject {

    @NSManaged var answerId: NSNumber
    @NSManaged var answer: String
    @NSManaged var question: NSManagedObject

    // Standard Core Data init method.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    

}
