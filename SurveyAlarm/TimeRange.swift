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
    var startDateStr : String
    var dateArr : [String]
    var alarmDateArr: [Int]
    let timeFormatter : NSDateFormatter
    let daysRepeated = 2
    
    
    init(timeStart : NSDate, timeEnd : NSDate){
        self.choiceHourArr = []
        self.choiceMinArr = []
        self.dateArr = []
        self.alarmDateArr = []
        self.timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "dd-MM-yyyy"
        self.dateArr = timeFormatter.stringFromDate(timeStart).componentsSeparatedByString("-")
        self.startDateStr = timeFormatter.stringFromDate(timeStart)
        self.startDateStr = startDateStr + " 00:00"
        timeFormatter.dateFormat = "H" //Converts to 24 hour
        timeStart24 = Int(timeFormatter.stringFromDate(timeStart))!
        timeEnd24 = Int(timeFormatter.stringFromDate(timeEnd))!
        
        randomize(timeStart24, timeEnd: timeEnd24)
    }
    
    func generateAlarmTimes() -> Array <Int>{
//        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//        var startDateNSDate = timeFormatter.dateFromString(startDateStr)
        for i in 0...daysRepeated - 1{
            var choiceOffset = 0
            for j in 0...2{
                var secondsOffset = (choiceHourArr[choiceOffset + j] * 3600) + (choiceMinArr[choiceOffset + j] * 60)
                if i != 0{
                    secondsOffset += 86400 * i //Day offset
                    alarmDateArr.append(secondsOffset)
                }
            }
            choiceOffset += 3
        }
        return alarmDateArr
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
        for i in 0...daysRepeated - 1{
            for j in 0...2{
                if arc4random_uniform(2) == 0{
                    choice += 2
                }
                else{
                    choice += 3
                }
                choiceHourArr.append(hourArr[choice])
                choiceMinArr.append(Int(arc4random_uniform(62)))
            }
        }
    }
    
}