//
//  SurveyAnswer+CoreDataProperties.swift
//  SAHC
//
//  Created by Michael Hari on 4/9/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SurveyAnswer {

    @NSManaged var questionId: NSNumber?
    @NSManaged var answerValues: NSObject?
    @NSManaged var answerTxt: String?

}
