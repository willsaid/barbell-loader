//
//  VideoViewController.swift
//  QuestionBot
//
//  Created by Will Said on 2/26/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    
    private let APP_ID = "1358135284"
    
    @IBOutlet weak var appStore: UIButton!
    
    
    @IBAction func appStoreTapped(_ sender: UIButton) {
        rateApp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appStore.layer.cornerRadius = 10
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
