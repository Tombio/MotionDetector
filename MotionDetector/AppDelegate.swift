//
//  AppDelegate.swift
//  MotionDetector
//
//  Created by Tomi Lahtinen on 29/03/16.
//  Copyright © 2016 Tomi Lahtinen. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

extension CMMotionActivity {
    func humanReadable() -> String {
        if self.walking {
            return "Walking"
        }
        else if self.stationary {
            return "Stationary"
        }
        else if self.automotive {
            return "Automotive"
        }
        else if self.running {
            return "Running"
        }
        else if self.cycling {
            return "Cycling"
        }
        else {
            return "Unknown"
        }

    }
}

extension CMMotionActivityConfidence {
    func humanReadable() -> String {
        if self == .High {
            return "High"
        }
        else if self == .Medium {
            return "Medium"
        }
        else {
            return "Low"
        }
    }
}

