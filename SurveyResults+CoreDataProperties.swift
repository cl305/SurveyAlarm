//
//  SurveyResults+CoreDataProperties.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/13/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SurveyResults {

    @NSManaged var identifier: String?
    @NSManaged var answers: String?
    @NSManaged var date: NSDate?

}
