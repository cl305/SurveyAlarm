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

    @IBOutlet weak var timePicker: UIDatePicker!
    var strTime : NSDate?
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBAction func setAlarms(sender: AnyObject) {
        print("hey")
        var timeFormatter = NSDateFormatter()
                    timeFormatter.dateFormat = "hh:m a"
//        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = timeFormatter.stringFromDate(strTime!)
        print(strDate)
    }
    
    func setNotification(){
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Hey you!"
        notification.alertAction = "Ok"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)

    }

    @IBAction func setTime(sender: AnyObject) {
        print("heyyyyyy")
        strTime = timePicker.date
    }

}

