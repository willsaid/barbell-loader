//
//  Alert.swift
//  Barbell Loader
//
//  Created by Will Said on 7/14/18.
//  Copyright © 2018 Will Said. All rights reserved.
//

import UIKit

struct Alert {
    
    
    static func okAlert(title: String, message: String, completion: (() -> ())? = nil) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        
        Alert.present(alertVC, completion: completion)
    }
    
    
    private static func present(_ alert: UIAlertController, completion: (() -> ())?) {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: completion)
    }
    
    
    
}
