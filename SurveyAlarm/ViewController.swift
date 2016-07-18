//
//  ViewController.swift
//  SurveyAlarm
//
//  Created by Cody Li on 6/21/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation
import CoreData

//#import "SurveyAlarm-Bridging-Header.h"

class ViewController: UIViewController, ORKTaskViewControllerDelegate{

    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeRangeLabel: UILabel!
    
    
    var strTime : NSDate?
    var timeFormatter : NSDateFormatter?
    var timeIncreArr : [Int] = []
    var myTimeRange : TimeRange?
    var moc : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeFormatter = NSDateFormatter()
        self.timeFormatter!.dateFormat = "hh:mm a"
        self.myTimeRange = nil
        self.strTime = NSDate()
        self.moc = DataController().managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        setNotificationPermission()
    }
    
    //Notifications
    func setNotificationPermission(){
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    @IBAction func setAlarms(sender: AnyObject) {
        timeFormatter!.dateFormat = "dd-MM-yyyy HH:mm"
        let myDate = NSDate()
        print(timeIncreArr.count)
        
        for increment in timeIncreArr{
            timeFormatter!.dateFormat = "dd-MM-yyyy hh:mm a"
            let incrementDouble = Double(increment)
            print(timeFormatter!.stringFromDate((myDate.dateByAddingTimeInterval(incrementDouble))))
        }
    }
    
    func setNotification(increment: Double){
        let notification = UILocalNotification()
        //        notification.fireDate = timeFormatter!.dateFromString(strTime?.dateByAddingTimeInterval(increment))
        notification.fireDate = strTime?.dateByAddingTimeInterval(increment)
        notification.alertBody = "Swipe here to complete a survey."
        notification.alertAction = "complete survey"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "Survey"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

    }

    @IBAction func setTime(sender: AnyObject) {
        strTime = timePicker.date
        timeFormatter!.dateFormat = "hh:mm a" 
        timeRangeLabel.text = timeFormatter!.stringFromDate((strTime)!) + " - " + timeFormatter!.stringFromDate((strTime?.dateByAddingTimeInterval(50400))!)
        myTimeRange = TimeRange(timeStart: strTime!, timeEnd: (strTime?.dateByAddingTimeInterval(50400))!)
        timeIncreArr = (myTimeRange?.generateAlarmTimes())!
    }
    
    //Survey
    @IBOutlet weak var surveyButton: NSLayoutConstraint!
    
    @IBAction func surveyTapped(sender : AnyObject){
        let choice = Int(arc4random_uniform(4))
        var taskViewController : ORKTaskViewController
        switch choice {
        case 0:
            taskViewController = ORKTaskViewController(task: FRSurveyTask, taskRunUUID: nil)
        case 1:
            taskViewController = ORKTaskViewController(task: CheckAllSurveyTask, taskRunUUID: nil)
        case 2:
            taskViewController = ORKTaskViewController(task: MCSurveyTask, taskRunUUID: nil)
        case 3:
            taskViewController = ORKTaskViewController(task: LikertSurveyTask, taskRunUUID: nil)
        default:
            taskViewController = ORKTaskViewController(task: CheckAllSurveyTask, taskRunUUID: nil)
        }
        
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        let moc = DataController().managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName("SurveyResults", inManagedObjectContext: moc) as! SurveyResults
        
        if (reason == .Completed){
            if let results = taskViewController.result.results as? [ORKStepResult] {
                for stepResult: ORKStepResult in results {
                    for result in stepResult.results!{
                        let questionID = result.identifier
                        entity.setValue(questionID, forKey: "identifier")
                        if let questionResult = result as? ORKTextQuestionResult{
                            entity.setValue(questionResult.endDate, forKey: "date")
                            entity.setValue(questionResult.textAnswer, forKey: "answer")
                        }
                        else if let questionResult = result as? ORKQuestionResult {
                            let str = questionResult.answer as? NSArray
                            entity.setValue(questionResult.endDate, forKey: "date")
                            var response : String = ""
                            for choices in str!{
                                response = response + "\(choices), "
                            }
                            entity.setValue(response, forKey: "answers")
                        }
                    }
                }
            }
        }
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
        fetchRecord()
    }
        
    func fetchRecord() {
        let moc = DataController().managedObjectContext
        let recordFetch = NSFetchRequest(entityName: "SurveyResults")
        
        do {
            let fetchedRecord = try moc.executeFetchRequest(recordFetch) as! [SurveyResults]
            for record in fetchedRecord {
                if let stringID = record.valueForKey("identifier") as? String{
                    print(stringID)
                }
                if let stringAns = record.valueForKey("answers") as? String {
                    print(stringAns)
                }
                
            }
        } catch {
            fatalError("Failed to fetch record: \(error)")
        }
    }

}

