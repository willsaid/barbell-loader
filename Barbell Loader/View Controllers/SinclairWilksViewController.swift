//
//  SinclairWilksViewController.swift
//  QuestionBot
//
//  Created by Will Said on 2/11/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//


import UIKit

class SinclairWilksViewController: MyViewController {
    
    //IB Outlets
    
    @IBOutlet weak var wilksSwitch: UISwitch!
    
    @IBOutlet weak var lbSwitch: UISwitch!
    
    @IBOutlet weak var femaleSwitch: UISwitch!
    
    @IBOutlet weak var totalTextField: UITextField!
    
    @IBOutlet weak var bodyweightTextField: UITextField!
    
    @IBOutlet weak var scoreTextField: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var historyTextView: UITextView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sinclair and Wilks"
        categoryLabel.text = ""
        resultLabel.text = ""
    }
    
    
    
    
    @IBAction func goButtonClicked(_ sender: UIButton) {
        if bodyweightTextField.text != "" && totalTextField.text != "" && scoreTextField.text != "" {
            return
        } else if bodyweightTextField.text != "" && totalTextField.text != "" {
            //display the score
            getScore()
        } else if bodyweightTextField.text != "" && scoreTextField.text != "" {
            //display total
            getTotal()
        } else if totalTextField.text != "" && scoreTextField.text != "" {
            //display bodyweight
            getBodyweight()
        }
    }
    
    func updateHistory(total: String, bw: String, score: String) {
        bodyweightTextField.resignFirstResponder()
        scoreTextField.resignFirstResponder()
        totalTextField.resignFirstResponder()
        
        let stringFirst = "T: " + total
        let stringSecond = ", BW: " + bw
        let stringThird = ", Score: " + score + "\n"
        let string = stringFirst + stringSecond + stringThird
        historyTextView.text = string + historyTextView.text
    }
    
    func getCoefficient(bodyweight: Double) -> Double {
        if wilksSwitch.isOn {
            return Wilks(lbs: lbSwitch.isOn, female: femaleSwitch.isOn).coefficient(bw: bodyweight)
        } else {
            return Sinclair(lbs: lbSwitch.isOn, female: femaleSwitch.isOn).coefficient(bodyweight: bodyweight)
        }
    }
    
    
    
    
    
    func getScore() {
        guard let bodyweightText = bodyweightTextField.text,
            let bodyweight = Double(bodyweightText),
            let totalText = totalTextField.text,
            var total = Double(totalText) else {return}
        
        if lbSwitch.isOn {
            total *= conversionDecimal
        }
        
        let coef = getCoefficient(bodyweight: bodyweight)
        
        resultLabel.text = String((total * coef).rounded())
        
        if wilksSwitch.isOn {
            categoryLabel.text = "Wilks: "
        } else {
            categoryLabel.text = "Sinclair: "
        }
        
        let score = String((total * coef).rounded())
        updateHistory(total: totalText, bw: bodyweightText, score: score)
    }
    
    
    
    func getTotal() {
        guard let bodyweightText = bodyweightTextField.text,
            let bodyweight = Double(bodyweightText),
            let scoreText = scoreTextField.text,
            let score = Double(scoreText) else {return}
        
        let coef = getCoefficient(bodyweight: bodyweight)
        var total = (score / coef).rounded()
        if lbSwitch.isOn {
            total /= conversionDecimal
            total = total.rounded()
        }
        resultLabel.text = String(total)
        categoryLabel.text = "Total Needed: "
        
        updateHistory(total: String(total), bw: bodyweightText, score: scoreText)
    }
    
    
    
    
    func getBodyweight() {
        guard let totalText = totalTextField.text,
            let total = Double(totalText),
            let scoreText = scoreTextField.text,
            let score = Double(scoreText) else {return}
        
        let bw: Int
        if wilksSwitch.isOn {
            bw = Wilks(lbs: lbSwitch.isOn, female: femaleSwitch.isOn).bodyweight(total: total, score: score)
        } else {
            bw = Sinclair(lbs: lbSwitch.isOn, female: femaleSwitch.isOn).bodyweight(total: total, score: score)
        }
        resultLabel.text = String(bw)
        categoryLabel.text = "Bodyweight Needed: "
        
        updateHistory(total: totalText, bw: String(bw), score: scoreText)
    }
    
    
    
    
    

    
}
