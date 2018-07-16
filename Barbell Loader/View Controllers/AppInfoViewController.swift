//
//  AppInfoViewController.swift
//  QuestionBot
//
//  Created by Will Said on 12/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    private let APP_ID = "1322247393"

    @IBOutlet weak var review: UIButton!
    
    
    @IBAction func reviewTapped(_ sender: UIButton) {
        rateApp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        review.layer.cornerRadius = 10
    }
    
    
    func rateApp() {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/id" + APP_ID) else {
            Alert.okAlert(title: "Error", message: "Unable to access App Store")
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if !success {
                    Alert.okAlert(title: "Error", message: "Unable to access App Store")
                }
            })
        } else {
            if !UIApplication.shared.openURL(url) {
                Alert.okAlert(title: "Error", message: "Unable to access App Store")
            }
        }
    }
}
