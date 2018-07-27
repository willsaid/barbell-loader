//
//  SinclairWilks.swift
//  Barbell Loader
//
//  Created by Will Said on 7/27/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation


class Sinclair: Score {

    
    func bodyweight(total: Double, score: Double) -> Int {
        //SINCLAIR
        // total * sinclair coefficient = sinclair total
        //
        // sinclair coefficient = 10 ^ (AX^ 2 if z <= b,
        //                      = 1             if z > b.
        //given bodyweight z.
        //
        //
        // Men
        // A = 0.751945030
        // b= 175.508 kg
        // Women
        // A = 0.783497476
        // b = 153.655 kg
        //
        // X = log(10) (z / b)
        //
        // given my math, this makes the bodyweight equal to: (could be wrong)
        // z = b * 10 ^ (Log10(S/T) / A)
        
        var Z: Double //return value
        let T: Double
        let A: Double
        let b: Double
        if lbs {
            T = total * conversionDecimal
        } else {
            T = total
        }
        if female {
            A = 0.783497476
            b = 153.655
        } else {
            A = 0.751945030
            b = 175.508
        }
        
        let logs = (Double((log(2.0) + log(5.0)))).squareRoot() * (log(score) - log(T)).squareRoot()
        let exponent = -logs/(A.squareRoot())
        Z = b * pow(M_E, exponent)
        
        if lbs {
            Z /= conversionDecimal
        }
        
        return self.check(value: Z)
        
        
    }
    
    
    func coefficient(bodyweight: Double) -> Double {
        //SINCLAIR
        // total * sinclair coefficient = sinclair total
        //
        // sinclair coefficient = 10 ^ (A(X ^ 2) if z <= b,
        //                      = 1             if z > b.
        //given bodyweight z.
        //
        // given my math, this makes the bodyweight equal to: (could be wrong)
        // z = 10 ^ (log10(b) + sqrt( (log10( (sinclair/total) / A))))
        //
        // Men
        // A = 0.751945030
        // b= 175.508 kg
        // Women
        // A = 0.783497476
        // b = 153.655 kg
        //
        // X = log(10) (z / b)
        
        let z: Double
        let A: Double
        let b: Double
        if lbs {
            z = bodyweight * conversionDecimal
        } else {
            z = bodyweight
        }
        if female {
            A = 0.783497476
            b = 153.655
        } else {
            A = 0.751945030
            b = 175.508
        }
        if z <= b {
            let X = log10(z / b)
            let AXsquared = A * X * X
            return pow(10, AXsquared)
        } else {
            return 1
        }
    }
    
    
    

    
}
