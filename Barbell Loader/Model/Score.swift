//
//  Score.swift
//  Barbell Loader
//
//  Created by Will Said on 7/27/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation

class Score {
    
    let lbs: Bool
    let female: Bool
    
    init(lbs: Bool, female: Bool) {
        self.lbs = lbs
        self.female = female
    }
    
    func check(value: Double) -> Int {
        if value > Double(Int.max) || value < 0 {
            return 0
        }
        
        return Int(value.rounded())
    }
    
}
