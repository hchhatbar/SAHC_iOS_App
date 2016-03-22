//
//  CoreDataManager.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/26/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

/*

Singleton controller to manage the main Core Data stack for the application. It vends a persistent store coordinator, the managed object model, and a URL for the persistent store.
*/

import Foundation
import CoreData


class CoreDataManager {
    
    private struct Constants{
        static let applicationDocumentsDirectoryName = "com.appforcause.sahc"
        static let mainStoreFileName = "sahc.storedata"
        static let errorDomain = "CoreDataManager"
    }
    
    class var sharedManager: CoreDataManager{
        struct Singleton{
            static let coreDataManager = CoreDataManager()
        }
        
        return Singleton.coreDataManager
    }
    
    /// The managed object model for the application.
    // Schema for the application
    lazy var managedObjectModel:NSManagedObjectModel = {
        // This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DB", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.AppForCause.TestCoreData" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
        }()
   
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("sahc.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch _ {
            
        }
        
        
//        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil) == nil {
//            coordinator = nil
//            // Report any error we got.
//            var dict = [String: AnyObject]()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//            dict[NSUnderlyingErrorKey] = error
//            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            // Replace this with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog("Unresolved error \(error), \(error!.userInfo)")
//            abort()
//        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()

    lazy var mainContext : NSManagedObjectContext? = {
        var mainContext = NSManagedObjectContext (concurrencyType: .MainQueueConcurrencyType)
        mainContext.parentContext = self.managedObjectContext
        mainContext.mergePolicy =  NSMergeByPropertyObjectTrumpMergePolicy
        return mainContext;
        
        }()
    
    // Worker context
    func newWorkerContext() -> NSManagedObjectContext {
        let workerContext = NSManagedObjectContext(concurrencyType:.PrivateQueueConcurrencyType)
        workerContext.parentContext = self.mainContext
        workerContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return workerContext;
    }
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            let error: NSError? = nil
            
                if moc.hasChanges {
                    do {
                    try moc.save()
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        NSLog("Unresolved error \(error), \(error!.userInfo)")
                        abort()
                    } catch _ {
                        
                    }
                }

            
        }
    }


}