//
//  extension.swift
//  MotionDetector
//
//  Created by Tomi Lahtinen on 30/03/16.
//  Copyright © 2016 Tomi Lahtinen. All rights reserved.
//

import Foundation
import CoreMotion

extension CMMotionActivity {
    func humanReadable() -> String {
        var ret = ""
        
        if self.walking {
            ret += "Walking "
        }
        if self.stationary {
            ret += "Stationary "
        }
        if self.automotive {
            ret += "Automotive "
        }
        if self.running {
            ret += "Running "
        }
        if self.cycling {
            ret += "Cycling "
        }
        if self.unknown {
            ret += "Unknown"
        }
        return ret
    }
    
    var valid: Bool {
        return automotive || cycling || stationary || walking || running
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

