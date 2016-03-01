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
        //let sortDescriptor = NSSortDescriptor(key: "sort_order", ascending: true)
        //let sortDescriptors = [sortDescriptor]
        //fetchRequest.sortDescriptors = sortDescriptors
        // Execute the Fetch Request
        let results = (try! managedObjectContext.executeFetchRequest(fetchRequest)) as! [Question]
        
        for question in results{

            print(question.sort_order)
            print(question.category)
            print(question.text)
            //println(question.answer.count)
            
            question.answer.enumerateObjectsUsingBlock { (elem, idx, stop) -> Void in
                print("\(idx): \(elem)")
            }
            
        }
        // Check for Errors
        if error != nil {
            print("Error in fectchAllActors(): \(error)")
        }
        // Return the results, cast to an array of Question objects
        return results //as! [Question]
    }
    
    func saveQuestion()
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

    func saveQuestions(questions:JSON)
    {
/*
@NSManaged var answer: NSOrderedSet*/

        for index in 0...questions["questions"].count-1{
            
            let context =  managedObjectContext
            let entity =  NSEntityDescription.entityForName("Question", inManagedObjectContext: context)!
            
            let answerChoiceEntity =  NSEntityDescription.entityForName("AnswerChoice", inManagedObjectContext: context)!
            
            let question = Question(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
            
            question.category = questions["questions"][index]["category"]["description"].string!
            question.abbreviation = questions["questions"][index]["abbreviation"].string!
            question.type = questions["questions"][index]["type"].string!
            question.text = questions["questions"][index]["text"].string!
            question.label = questions["questions"][index]["label"].string!
            question.tip_text = questions["questions"][index]["tip_text"].string!

/*          question.helper = questions[index]["helper"].string!
            question.sort_order = questions[index]["sort_order"].number!
            question.active = "true" //(questions[index]["active"].string ? "true" : "false")!
            question.href = questions[index]["href"].string! */
            
            
            var answerChoices:[AnswerChoice] = []
            //var answerChoices = questions[index]["answer_options"]
            if(questions["questions"][index]["answer_options"].count > 0  ){ //&& index != 11 && index != 22){
            for answerIndex in 0...questions["questions"][index]["answer_options"].count - 1{
                if(Int(questions["questions"][index]["answer_options"][answerIndex]["value"].string!) != nil){
                let answerChoice = AnswerChoice(entity: answerChoiceEntity, insertIntoManagedObjectContext: managedObjectContext)
                answerChoice.answer_description = questions["questions"][index]["answer_options"][answerIndex]["description"].string!
                answerChoice.type = questions["questions"][index]["answer_options"][answerIndex]["type"].string!
                answerChoice.value = NSNumber(integer:Int(questions["questions"][index]["answer_options"][answerIndex]["value"].string!)!)
                answerChoice.sort_order = NSNumber(integer:Int(questions["questions"][index]["answer_options"][answerIndex]["sort_order"].string!)!)
                
                //answerChoice.abbreviation = questions[index]["answer_options"][answerIndex]["abbreviation"].string!
                //answerChoice.href = questions[index]["answer_options"][answerIndex]["href"].string!
                
                answerChoices.append(answerChoice)
                }
            }
            }
            let answerChoiceSet = NSOrderedSet(array: answerChoices)
            
            question.answer = answerChoiceSet
            CoreDataManager.sharedManager.saveContext()
            
            //println(questions[index]["text"].string)
        }
        
      /*  let context =  managedObjectContext //CoreDataManager.sharedManager.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Question", inManagedObjectContext: context)!
        
        let answerChoiceEntity =  NSEntityDescription.entityForName("AnswerChoice", inManagedObjectContext: context)!
        var question = Question(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    
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