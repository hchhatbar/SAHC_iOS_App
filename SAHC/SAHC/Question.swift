//
//  Question.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 11/5/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

@objc(Question)
class Question: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var helper: String
    @NSManaged var text: String
    @NSManaged var tip_text: String
    @NSManaged var abbreviation: String
    @NSManaged var type: String
    @NSManaged var label: String
    @NSManaged var sort_order: NSNumber
    @NSManaged var active: String
    @NSManaged var href: String
    @NSManaged var answer: NSOrderedSet

}
