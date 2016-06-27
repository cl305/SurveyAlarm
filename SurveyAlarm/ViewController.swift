//
//  ViewController.swift
//  SurveyAlarm
//
//  Created by Cody Li on 6/21/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {

    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeRangeLabel: UILabel!
    
    
    var strTime : NSDate?
    var timeFormatter : NSDateFormatter?
    override func viewDidLoad() {
        super.viewDidLoad()
        timeFormatter = NSDateFormatter()
        timeFormatter!.dateFormat = "hh:mm a"
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
        setNotification()
    }
    
    func setNotification(){
        let notification = UILocalNotification()
        var notDate = "24-06-2016 15:16"
        notification.fireDate = timeFormatter!.dateFromString(notDate)
        notification.alertBody = "Hey you!"
        notification.alertAction = "Ok"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

    }

    @IBAction func setTime(sender: AnyObject) {
        strTime = timePicker.date
        timeRangeLabel.text = timeFormatter!.stringFromDate((strTime)!) + " - " + timeFormatter!.stringFromDate((strTime?.dateByAddingTimeInterval(50400))!)
        
    }

}

