//
//  DataController.swift
//  SAHC
//
//  Created by Michael Hari on 4/9/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import UIKit
import CoreData

class DataController {
    
    // should initialize only once
    static let sharedInstance = DataController()
    
    var managedObjectContext: NSManagedObjectContext
    
    // don't let outside source init this class
    private init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("DB", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("sahc.sqlite")
            print(storeURL.absoluteString)
            do {
                let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                                 NSInferMappingModelAutomaticallyOption: true]
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        //}
    }
}
