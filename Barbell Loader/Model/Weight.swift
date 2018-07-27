//
//  Weight.swift
//  Barbell Loader
//
//  Created by Will Said on 7/12/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import UIKit


enum WeightType {
    case kg
    case lb
}



struct Weight {
    
    
    ///1 kg = 0.45359237 lb
    private let CONVERSION = 0.45359237
    
    ///updating this one will set @lastWeight
    static var currentWeight = Weight(amount: barweightstartingat45, type: .lb)
    
    
    // MARK: - INSTANCE VARIABLES
    var amount: Double
    var type: WeightType
    
    
    
    // MARK: - INITIALIZERS
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
    
    init(images: [UIImage], type: WeightType) {
        //passed in the plate images, need to construct a weight from it
        let weight = Weight.convert(images: images)
        if type == .kg {
            self.amount = weight.kilograms
        } else {
            self.amount = weight.pounds
        }
        self.type = type
    }
    
    
    
    
    
    // MARK: - COMPUTED PROPERTIES
    
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
    
    
    
    // MARK: - PRIVATE HELPERS
    
    private func truncation() -> String {
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
    private func check(value: Double) -> Int {
        if value > Double(Int.max) || value < 0 {
            return 0
        }
        
        return Int(value.rounded())
    }
    
    
    
    
    // MARK: - INIT HELPERS
    
    //converts image array into weight
    static func convert(images: [UIImage]) -> Weight {
        var weight = Weight(amount: barweightstartingat45, type: .lb)
        
        for weightImage in images {
            if weightImage == #imageLiteral(resourceName: "bigRed") {
                weight += Weight(amount: 50, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "bigBlue") {
                weight += Weight(amount: 40, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "bigYellow") {
                weight += Weight(amount: 30, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "bigGreen") {
                weight += Weight(amount: 20, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "white") {
                weight += Weight(amount: 10, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "littleRed") {
                weight += Weight(amount: 5, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "littleBlue") {
                weight += Weight(amount: 4, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "littleYellow") {
                weight += Weight(amount: 3, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "littleGreen") {
                weight += Weight(amount: 2, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "littleWhite") {
                weight += Weight(amount: 1, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "powerquarterkilo") {
                weight += Weight(amount: 0.5, type: .kg)
            } else if weightImage == #imageLiteral(resourceName: "weighted2.5kgcollar") {
                weight += Weight(amount: 5, type: .kg) //collars
            } else if weightImage == #imageLiteral(resourceName: "fortyfive") {
                 weight += Weight(amount: 90, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "thirtyfiveplate") {
                weight += Weight(amount: 70, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "twentyfive") {
                weight += Weight(amount: 50, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "ten") {
                weight += Weight(amount: 20, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "five") {
                weight += Weight(amount: 10, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "twohalf") {
                weight += Weight(amount: 5, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "onepound") {
                weight += Weight(amount: 2, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "threequarterplate") {
                weight += Weight(amount: 1.5, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "halfpoundplate") {
                weight += Weight(amount: 1, type: .lb)
            } else if weightImage == #imageLiteral(resourceName: "quarterpoundplate") {
                weight += Weight(amount: 0.5, type: .lb)
            }
        }
        
        
        return weight
    }
    
    
    
    
    
    // MARK: - OPERATORS
    
    static func + (_ left: Weight, _ right: Weight) -> Weight {
        return Weight(amount: left.pounds + right.pounds, type: .lb)
    }
    
    static func += (_ left: inout Weight, _ right: Weight) {
        left = left + right
    }
    
    static func == (_ left: Weight, _ right: Weight) -> Bool {
        return left.amount == right.amount && left.type == right.type
    }
    
    
    
}































