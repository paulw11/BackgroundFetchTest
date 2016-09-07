//
//  AppDelegate.swift
//  BackgroundFetchTest
//
//  Created by Paul Wilkinson on 30/08/2016.
//  Copyright © 2016 Paul Wilkinson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var backgroundTask: UIBackgroundTaskIdentifier?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[.Sound, .Alert, .Badge], categories: nil))
        
        application.setMinimumBackgroundFetchInterval(3600)
                return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let defaults = NSUserDefaults.standardUserDefaults()
        let now = NSDate().descriptionWithLocale(NSLocale.currentLocale())
        defaults.setObject(now, forKey: "suspend")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        
        self.backgroundTask = application.beginBackgroundTaskWithExpirationHandler {
            if let bgTask = self.backgroundTask {
                application.endBackgroundTask(bgTask)
                self.backgroundTask = nil
            }
        }
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            let localNotification = UILocalNotification()
            
            let random = arc4random_uniform(3)
            
            var result: UIBackgroundFetchResult = .NoData
            
            let now = NSDate().descriptionWithLocale(NSLocale.currentLocale())
            
            localNotification.alertBody = "No data \(now)"
            
            if random > 1 {
                localNotification.alertBody = "Fetched data \(now)"
                result = .NewData
            }
            
           
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(now, forKey: "background")
            
            completionHandler(result)
            
            if let bgTask = self.backgroundTask {
                application.endBackgroundTask(bgTask)
                self.backgroundTask = nil
            }
        }
    }
    
    


}

