//
//  WeightHistory.swift
//  Barbell Loader
//
//  Created by Will Said on 7/15/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

class WeightHistory {
    
    static var sharedInstance = WeightHistory()
    
    private var weights: [Weight] = [Weight(amount: 45, type: .lb)]
    
    func add(weight: Weight) {
        weights.append(weight)
    }
    
    func pop() -> Weight {
        if let weight = weights.popLast() {
            return weight
        }
        
        return Weight(amount: barweightstartingat45, type: .lb)
    }
    
}
