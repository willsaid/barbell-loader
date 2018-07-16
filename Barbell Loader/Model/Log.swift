//
//  Log.swift
//  Barbell Loader
//
//  Created by Will Said on 7/12/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation

struct Log {
    
    
    static func log(weight: Weight) {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        for _ in 0 ..< 11 {
            if let length = weightsLogged?.count {
                if length > 0 {
                    if weightsLogged?.last == "\n" {
                        weightsLogged?.removeLast()
                    }
                }
            }
        }
        
        
        
        
        if formatter.string(from: currentDateTime) != oldDate {
            //add today's date into log.
            let dayOfWeek = Date().dayOfWeek()!
            
            
            
            weightsLogged = weightsLogged! + "\n\n\n" + String(dayOfWeek) + " " + formatter.string(from: currentDateTime)
                + "\n        \n"
        }
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        if weight.type == .kg {  //kg
            
            weightsLogged = weightsLogged! + String(weight.amount) + " kg         " + formatter.string(from: currentDateTime) + "\n        \n        \n"
                + "\n\n\n\n\n\n\n\n\n\n\n"
        } else {
            
            let old = Double(weight.amount)
            
            if old < Double(Int.max) && (Double(Int(old)) == old.rounded()) {
                weightsLogged = weightsLogged! + String(Int(old)) + " lb         " + formatter.string(from: currentDateTime) + "\n        \n        \n"
                    + "\n\n\n\n\n\n\n\n\n\n\n"
            } else {
                weightsLogged = weightsLogged! + String(Int((old.rounded()))) + " lb         " + formatter.string(from: currentDateTime) + "\n        \n        \n"
                    + "\n\n\n\n\n\n\n\n\n\n\n"
            }
            
        }
        
        defaults.set(weightsLogged, forKey: "weightsLogged")
        
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        defaults.set(formatter.string(from: currentDateTime), forKey: "oldDate")
        oldDate = formatter.string(from: currentDateTime)
        
    }
    
}
