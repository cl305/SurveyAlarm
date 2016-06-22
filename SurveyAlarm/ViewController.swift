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
        setNotifications()
    }
    
    //Notifications
    func setNotifications(){
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }

}

