//
//  Answer.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 11/5/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var answerId: NSNumber
    @NSManaged var answerText: String
    @NSManaged var questionId: String

}
