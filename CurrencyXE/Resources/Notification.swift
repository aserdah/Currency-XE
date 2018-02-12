//
//  Notifaction.swift
//  E-Work Hackathon
//
//  Created by Ahmed on 12/17/17.
//  Copyright © 2017 aserdah. All rights reserved.
//

import UIKit

class Notification: NSObject {
    
    class func notificationAtTime (alertTitle: String ,alertBody: String,soundName : String = "default",hour: Int, minute: Int , second: Int){
        
    let localNotification = UILocalNotification.init()
    localNotification.alertTitle = alertTitle
    localNotification.alertBody = alertBody
    localNotification.soundName = soundName
   
    localNotification.fireDate =  Date().atTime(hour: hour, minute: minute, second: second)
    localNotification.repeatInterval = NSCalendar.Unit.day
    UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    class func notificationAfterTime(alertTitle: String ,alertBody: String,soundName : String = "default", second: Double){
        
        let localNotification = UILocalNotification.init()
        localNotification.alertTitle = alertTitle
        localNotification.alertBody = alertBody
        localNotification.soundName = soundName
        
        localNotification.fireDate =  Date().addingTimeInterval(second)
        localNotification.repeatInterval = NSCalendar.Unit.day
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }

}
