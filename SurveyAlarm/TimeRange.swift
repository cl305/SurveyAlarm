//
//  TimeRange.swift
//  SurveyAlarm
//
//  Created by Cody Li on 6/24/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class TimeRange{

    let timeStart24 : Int
    let timeEnd24 : Int
    var choiceHourArr : [Int]
    var choiceMinArr : [Int]
    init(timeStart : NSDate, timeEnd : NSDate){
        self.choiceHourArr = []
        self.choiceMinArr = []
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "H" //Converts to 24 hour
        timeStart24 = Int(timeFormatter.stringFromDate(timeStart))!
        timeEnd24 = Int(timeFormatter.stringFromDate(timeEnd))!
    }
    
    func generateAlarmTimes(){
        
    }
    
    func randomize(timeStart : Int, timeEnd : Int){
        var indices = abs(timeStart - timeEnd)
        var hourArr : [Int] = []
        
        for i in 0...indices{
            var timeElement = timeStart + i
            if timeElement >= 24{
                hourArr.append(timeElement - 24)
            }
            else{
                hourArr.append(timeElement)
            }
        }
        
        var choice = 0
        for i in 0...2{
            if arc4random_uniform(1) == 0{
                choice += 2
            }
                
            else{
                choice += 3
            }
            choiceHourArr.append(hourArr[choice])
            choiceMinArr.append(Int(arc4random_uniform(61)))
        }
    }
    
}