//
//  ViewController.swift
//  SurveyAlarm
//
//  Created by Cody Li on 6/21/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate{

    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeRangeLabel: UILabel!
    
    
    var strTime : NSDate?
    var timeFormatter : NSDateFormatter?
    var timeIncreArr : [Int] = []
    var myTimeRange : TimeRange?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeFormatter = NSDateFormatter()
        self.timeFormatter!.dateFormat = "hh:mm a"
        self.myTimeRange = nil
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        let myStep = ORKInstructionStep(identifier: "intro")
//        myStep.title = "Welcome to ResearchKit"
        setNotificationPermission()
    }
    
    //Notifications
    func setNotificationPermission(){
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    @IBAction func setAlarms(sender: AnyObject) {
        timeFormatter!.dateFormat = "dd-MM-yyyy HH:mm"
        var myDate = NSDate()
        print(timeIncreArr.count)
        
        for increment in timeIncreArr{
            timeFormatter!.dateFormat = "dd-MM-yyyy hh:mm a"
            var incrementDouble = Double(increment)
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
        timeRangeLabel.text = timeFormatter!.stringFromDate((strTime)!) + " - " + timeFormatter!.stringFromDate((strTime?.dateByAddingTimeInterval(50400))!)
        myTimeRange = TimeRange(timeStart: strTime!, timeEnd: (strTime?.dateByAddingTimeInterval(50400))!)
        timeIncreArr = (myTimeRange?.generateAlarmTimes())!
    }
    
    //Survey
    @IBOutlet weak var surveyButton: NSLayoutConstraint!
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject){
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }

}

