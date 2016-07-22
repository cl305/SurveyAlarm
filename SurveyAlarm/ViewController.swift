//
//  ViewController.swift
//  SurveyAlarm
//
//  Created by Cody Li on 6/21/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import UIKit
//import ResearchKit
import Foundation
import CoreData
import ResearchKit

//#import "SurveyAlarm-Bridging-Header.h"

class ViewController: UIViewController, ORKTaskViewControllerDelegate{

    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeRangeLabel: UILabel!
    @IBOutlet weak var exportButton: UIButton!
    
    
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
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        timeFormatter!.dateFormat = "dd-MM-yyyy HH:mm"
        for increment in timeIncreArr{
            timeFormatter!.dateFormat = "dd-MM-yyyy hh:mm a"
            let incrementDouble = Double(increment)
            setNotification(incrementDouble)
        }
    }
    
    func setNotificationSettings() {
        var notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        var surveyAction = UIMutableUserNotificationAction()
        surveyAction.identifier = "completeSurvey"
        surveyAction.title = "Complete survey"
        surveyAction.activationMode = UIUserNotificationActivationMode.Foreground
        surveyAction.destructive = false
        surveyAction.authenticationRequired = false
        
        let actionsArray = NSArray(objects: surveyAction)
        
        var surveyReminderCategory = UIMutableUserNotificationCategory()
        surveyReminderCategory.identifier = "surveyReminderCategory"
        surveyReminderCategory.setActions(actionsArray as! [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
        let categoriesForSettings = NSSet(objects: surveyReminderCategory)
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings as! Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
    }
    
    func setNotification(increment: Double){
        let notification = UILocalNotification()
        strTime = NSDate()
        timeFormatter!.dateFormat = "dd-MM-yyyy hh:mm a"
        print(timeFormatter!.stringFromDate((strTime?.dateByAddingTimeInterval(increment))!))
        notification.fireDate = strTime?.dateByAddingTimeInterval(increment)
        notification.alertBody = "Swipe here to complete a survey."
        notification.alertAction = "Complete survey"
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
                            print(questionResult.endDate)
                            entity.setValue(questionResult.textAnswer, forKey: "answers")
                        }
                        else if let questionResult = result as? ORKQuestionResult {
                            let str = questionResult.answer as? NSArray
                            entity.setValue(questionResult.endDate, forKey: "date")
                            var response : String = "{"
                            for choices in str!{
                                response = response + "\(choices) "
                            }
                            response = response + "}"
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
    }
    
    @IBAction func exportData(sender: AnyObject) {
        let moc = DataController().managedObjectContext
        let recordFetch = NSFetchRequest(entityName: "SurveyResults")
        var dataString = ""
        do {
            let fetchedRecord = try moc.executeFetchRequest(recordFetch) as! [SurveyResults]
            for record in fetchedRecord {
                if let stringDate = record.valueForKey("date") as? NSDate {
                    self.timeFormatter?.dateFormat = "MM-dd-yyyy HH:mm"
                    if let formattedDate = timeFormatter!.stringFromDate(stringDate) as? String {
                        print(formattedDate)
                        dataString = dataString + "\(formattedDate), "
                    }
                }
                if let stringID = record.valueForKey("identifier") as? String{
                    print(stringID)
                    dataString = dataString + "\(stringID), "
                }
                if let stringAns = record.valueForKey("answers") as? String {
                    let formattedString = stringAns.stringByReplacingOccurrencesOfString(",", withString: ";")
                    print(formattedString)

                    dataString = dataString + "\(formattedString), \n"
                }
            }
        } catch {
            fatalError("Failed to fetch record: \(error)")
        }
        let str = "Date, QuestionID, Response \n" + dataString
        let fileName = getDocumentsDirectory().stringByAppendingPathComponent("output.csv")
        
        do {
            try str.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            fatalError("Failed to save to file: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

