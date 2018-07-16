//
//  RequestReview.swift
//  Barbell Loader
//
//  Created by Will Said on 7/12/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import StoreKit

struct RequestReview {
    
    
    static func request() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            if howManyTimesOpenedApp >= 3 && hasReviewed == false {
                if #available( iOS 10.3,*) {
                    SKStoreReviewController.requestReview()
                }
                hasReviewed = true
                defaults.set(hasReviewed, forKey: "hasReviewed")
            }
        })
    }
    
}
