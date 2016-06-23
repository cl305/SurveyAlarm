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
    
//    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.navigationBarHidden = true
//        
//        UIApplication.sharedApplication().statusBarHidden = false
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        
//        let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
//        if statusBar.respondsToSelector("setBackgroundColor:"){
//            statusBar.backgroundColor = UIColor.redColor()
//        }
//    }
    
    //Notifications
    func setNotificationPermission(){
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    @IBAction func setAlarms(sender: AnyObject) {
        print("hey")
//        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = timeFormatter!.stringFromDate(strTime!)
        
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
        strTime = timePicker.date
//        print(strTime?.dateByAddingTimeInterval(43200))
//        print("\(timeFormatter!.stringFromDate(strTime!))")
        timeRangeLabel.text = timeFormatter!.stringFromDate((strTime)!) + " - " + timeFormatter!.stringFromDate((strTime?.dateByAddingTimeInterval(50400))!)
    }

}

