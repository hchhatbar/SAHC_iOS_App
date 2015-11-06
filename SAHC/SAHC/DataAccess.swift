//
//  DataAccess.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/26/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation
import CoreData

class DataAccess: NSObject{
    let kEntityName = "Question"

    /// Managed object context for the view controller (which is bound to the persistent store coordinator for the application).
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        moc.persistentStoreCoordinator = CoreDataManager.sharedManager.persistentStoreCoordinator
        
        return moc
        }()

    func getQuestions() -> [Question] {
        let error: NSErrorPointer = nil
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName:"Question")
        // Execute the Fetch Request
        let results = managedObjectContext.executeFetchRequest(fetchRequest, error: error) as! [Question]
        // Check for Errors
        if error != nil {
            println("Error in fectchAllActors(): \(error)")
        }
        // Return the results, cast to an array of Question objects
        return results
    }
    
    func saveQuestions()
    {
        
        let context =  managedObjectContext //CoreDataManager.sharedManager.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Question", inManagedObjectContext: context)!
        
        let answerChoiceEntity =  NSEntityDescription.entityForName("AnswerChoice", inManagedObjectContext: context)!
        var question = Question(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        /*
        question.questionId = "testIdP"
        question.questionText = "some question text"
        question.questionType = "some question type"
        question.categoryId = 1
        question.tipText = "some tip text"
        question.helper = "some helper text"
        
        let answerChoice = AnswerChoice(entity: answerChoiceEntity, insertIntoManagedObjectContext: managedObjectContext)
        answerChoice.answerId = 3
        answerChoice.answer = "some answer text"
        
        let answerChoiceSet = NSOrderedSet(array: [answerChoice])
        //:[AnswerChoice] = []
        //answerChoiceList.append(answerChoice)
        
        question.answer = answerChoiceSet

        CoreDataManager.sharedManager.saveContext()*/
        
              
    }

    
}