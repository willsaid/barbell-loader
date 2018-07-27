//
//  Wilks.swift
//  Barbell Loader
//
//  Created by Will Said on 7/27/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation

class Wilks: Score {
    
    
    func coefficient(bw: Double) -> Double {
        
        var x = bw
        
        if lbs {
            x = x * conversionDecimal
        }
        
        var a: Double
        var b: Double
        var c: Double
        var d: Double
        var e: Double
        var f: Double
        
        if female {
            a = 594.31747775582
            b = -27.23842536447
            c = 0.82112226871
            d = -0.00930733913
            e = 4.731582E-05
            f = -9.054E-08
        } else {
            a = -216.0475144
            b = 16.2606339
            c = -0.002388645
            d = -0.00113732
            e = 7.01863E-06
            f = -1.291E-08
        }
        
        
        let coefficient = 500.0 / (a + b * x + c * x * x + d * pow(x, 3) + e * pow(x, 4) + f * pow(x, 5))
        
        return coefficient
        
    }
    
    
    func bodyweight(total: Double, score: Double) -> Int {
        //return bw
        
        //coefficient = score / total.
        //find coefficient:
        var t = total
        if lbs {
            t = t * conversionDecimal
        }
        let coefficient = score / t
        
        let coefficients = female ? Coefficients.wilksWomen.enumerated() : Coefficients.wilksMen.enumerated()
        
        for (index, value) in coefficients {
            if value < coefficient {
                if lbs {
                    let value = Double(index + 40) / conversionDecimal
                    return check(value: value)
                } else {
                    return index + 40
                }
            }
        }
        
        return 0
    }
    
    
    
    
    
    
    
}










