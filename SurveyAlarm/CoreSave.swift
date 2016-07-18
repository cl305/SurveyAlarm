//
//  CoreSave.swift
//  SurveyAlarm
//
//  Created by Cody Li on 7/13/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import CoreData

class CoreSave{
    
    var surveyData : NSManagedObject
    
    init(){
        self.surveyData = NSManagedObject() 
    }
}