//
//  RepMax.swift
//  Barbell Loader
//
//  Created by Will Said on 7/27/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import Foundation


/// calculate the one rep max given a weight and reps,
/// and then the 2-10 rep maxes
class RepMax {
    
    var epley: Double {
        return weight * (1 + reps / 30)
    }
    
    var brzycki: Double {
        return weight * (36 / (37 - reps))
    }
    
    var lombardi: Double {
        return weight * pow(reps, 0.10)
    }
    
    var weights: [Double] = [
        116, 109, 106, 103, 100, 97, 95, 93, 91, 88
    ]
    
    
    var weight: Double
    
    var reps: Double
    
    
    
    init(weight: Double, reps: Double) {
        self.weight = weight
        self.reps = reps
    }
    
    
    func getRepMaxes() -> [Double] {
        let orm = calculateOneRepMax()
        return calculateOtherRepMaxes(orm: orm)
    }
    
    
    ///calculates 1RM
    private func calculateOneRepMax() -> Double {
        
        if reps == 1 {
            return weight
        }
        
        let average = (epley + brzycki + lombardi) / 3.0
        return average.rounded()
    }
    
    
    //calculates 2RM - 10RM
    private func calculateOtherRepMaxes(orm: Double) -> [Double] {
        var weights = [orm]
        
        for i in 2 ... 10 {
            let l = lombardi / pow(Double(i), 0.10)
            let b = (brzycki * Double(37 - i)) / 36
            let e = epley / ((1 + (Double(i) / 30)))
            let avg = ((l + b + e) / 3).rounded()
            weights.append(avg)
        }
        
        return weights
    }
    
    
}
