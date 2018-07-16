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
        go()
    }
    
    
    
    
    func go() {
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
            bw = computeWilksBodyweight(total: total, score: score)
        } else {
            bw = computeSinclairBodyweight(total, score)
        }
        resultLabel.text = String(bw)
        categoryLabel.text = "Bodyweight Needed: "
        
        updateHistory(total: totalText, bw: String(bw), score: scoreText)
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
            return computeWilksCoefficient(bodyweight)
        } else {
            return computeSinclairCoefficient(bodyweight)
        }
    }
    
    
    
    func check(value: Double) -> Int {
        if value > Double(Int.max) || value < 0 {
            return 0
        }
        
        return Int(value.rounded())
    }
    
    
    
    
    
    func computeSinclairBodyweight(_ total: Double, _ score: Double) -> Int {
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
        if lbSwitch.isOn {
            T = total * conversionDecimal
        } else {
            T = total
        }
        if (femaleSwitch.isOn) {
            A = 0.783497476
            b = 153.655
        } else {
            A = 0.751945030
            b = 175.508
        }
        
        let logs = (Double((log(2.0) + log(5.0)))).squareRoot() * (log(score) - log(T)).squareRoot()
        let exponent = -logs/(A.squareRoot())
        Z = b * pow(M_E, exponent)
        
        if lbSwitch.isOn {
            Z /= conversionDecimal
        }
        
        return check(value: Z)
        

    }
    
    
    func computeSinclairCoefficient(_ bodyweight: Double) -> Double {
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
        if lbSwitch.isOn {
            z = bodyweight * conversionDecimal
        } else {
            z = bodyweight
        }
        if (femaleSwitch.isOn) {
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
    
    
    
    

    
    func computeWilksCoefficient(_ bw: Double) -> Double {
        
        var x = bw
        
        if lbSwitch.isOn {
            x = x * conversionDecimal
        }
   
        var a: Double
        var b: Double
        var c: Double
        var d: Double
        var e: Double
        var f: Double
        
        if femaleSwitch.isOn {
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
    
    
    func computeWilksBodyweight(total: Double, score: Double) -> Int {
        //return bw
        
        //coefficient = score / total.
        //find coefficient:
        var t = total
        if lbSwitch.isOn {
            t = t * conversionDecimal
        }
        let coefficient = score / t
        
        if femaleSwitch.isOn {
            for (index, value) in Coefficients.wilksWomen.enumerated() {
                if value < coefficient {
                    if lbSwitch.isOn {
                        let value = Double(index + 40) / conversionDecimal
                        return check(value: value)
                    } else {
                        return index + 40
                    }
                }
            }
        } else {
            for (index, value) in Coefficients.wilksMen.enumerated() {
                if value < coefficient {
                    if lbSwitch.isOn {
                        let value = Double(index + 40) / conversionDecimal
                        return check(value: value)
                    } else {
                        return index + 40
                    }
                }
            }
        }
        
        return 0
    }
    
    
    
    

    
}
