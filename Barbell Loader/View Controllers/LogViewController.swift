//
//  LogViewController.swift
//  QuestionBot
//
//  Created by Will Said on 11/24/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit


var weightsLogged = defaults.string(forKey: "weightsLogged")



class LogViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Log"

        self.hideKeyboard()

        UITextView.appearance().tintColor = .yellow
        

        defaults.register(defaults: ["weightsLogged" : "Edit me!\nType in anything you want here, like sets and reps.\n"])
        textView.text = weightsLogged
    }
    
    
    

    @IBOutlet weak var textView: UITextView!
    
    


    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonActivated(_ sender: UIButton) {
        textView.resignFirstResponder()
        defaults.set(textView.text, forKey: "weightsLogged")
        weightsLogged = defaults.string(forKey: "weightsLogged")
    }


    override func viewDidAppear(_ animated: Bool) {
        self.textView.scrollRangeToVisible(NSMakeRange(Int(textView.contentSize.height), Int(textView.contentSize.height)))
    }
    
    
    
}




























