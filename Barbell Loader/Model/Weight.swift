//
//  Weight.swift
//  Barbell Loader
//
//  Created by Will Said on 7/12/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation


enum WeightType {
    case kg
    case lb
}



struct Weight {
    
    
    static func + (_ left: Weight, _ right: Weight) -> Weight {
        return Weight(amount: left.pounds + right.pounds, type: .lb)
    }
    
    static func == (_ left: Weight, _ right: Weight) -> Bool {
        return left.amount == right.amount && left.type == right.type
    }
    
    ///1 kg = 0.45359237 lb
    private let CONVERSION = 0.45359237
    
    
    ///updating this one will set @lastWeight
    static var currentWeight = Weight(amount: barweightstartingat45, type: .lb)
    
    
    
    
    var amount: Double
    var type: WeightType
    
    
    
    init(amount: Double, type: WeightType) {
        self.amount = amount
        self.type = type
    }
    
    init?(amount: String, type: WeightType) {
        if let amount = Double(amount) {
            self.amount = amount
            self.type = type
        } else {
            return nil
        }
    }
    
    
    
    
    
    //these are exact, not rounded
    
    var pounds: Double {
        if type == .kg {
            return (amount / CONVERSION)
        }
        return amount
    }
    
    var kilograms: Double {
        if type == .kg {
            return amount
        }
        return amount * CONVERSION
    }
    
    
    var toString: String {
        if type == .kg {
            return truncation()
        }
        
        //pounds
        return String(check(value: amount))
    }
    
    var converted: Weight {
        if type == .kg {
            return Weight(amount: amount / CONVERSION, type: .lb)
        }
        
        return Weight(amount: amount * CONVERSION, type: .kg)
    }
    
    
    func truncation() -> String {
        if (amount * 10).truncatingRemainder(dividingBy: 10.0) == 5 {
            //0.5
            
            return String(((amount * 10).rounded() / 10.0))
            
        } else if (amount * 100).truncatingRemainder(dividingBy: 100.0) == 25
            || (amount * 100).truncatingRemainder(dividingBy: 100.0) == 75 {
            //0.25 or 0.75
            
            return String(((amount * 100).rounded() / 100.0))
            
        } else {
            //whole number
            
            return String(check(value: amount))
            
        }
    }
    
    ///check Double is within bounds of Int
    func check(value: Double) -> Int {
        if value > Double(Int.max) || value < 0 {
            return 0
        }
        
        return Int(value.rounded())
    }
    
    
    
    
    
}


