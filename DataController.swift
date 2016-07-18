//
//  DataController.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/13/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController: NSObject {
    var managedObjectContext : NSManagedObjectContext
    
    override init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("SurveyAlarm", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex-1]
        
        let storeURL = docURL.URLByAppendingPathComponent("SurveyResults.sqlite")
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}