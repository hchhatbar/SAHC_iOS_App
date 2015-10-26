//
//  AnswerChoice.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

class AnswerChoice: NSManagedObject {

    @NSManaged var answerId: NSNumber
    @NSManaged var answer: String
    @NSManaged var question: NSManagedObject

}
