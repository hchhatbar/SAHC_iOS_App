//
//  Answer.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/26/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var questionId: String
    @NSManaged var answerId: NSNumber
    @NSManaged var answerText: String
    
    
   
}
