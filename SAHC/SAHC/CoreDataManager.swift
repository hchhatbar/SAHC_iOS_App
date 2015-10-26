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
    
    static let sharedManager = CoreDataManager()
    static let applicationDocumentsDirectoryName = "com.sahc.hra"
    static let mainStoreFileName = "sahc.storedata"
    static let errorDomain = "CoreDataManager"
    
    
    /// The managed object model for the application.
    lazy var managedObjectModel: NSManagedObjectModel = {
        /*
        This property is not optional. It is a fatal error for the application
        not to be able to find and load its model.
        */
        let modelURL = NSBundle.mainBundle().URLForResource("sahc", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    
   
}