//
//  RepCalcViewController.swift
//  QuestionBot
//
//  Created by Will Said on 2/16/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class RepCalcViewController: MyViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func weightChanged(_ sender: Any) {
        guard let weightText = weightTextField.text, weightText.count > 0 else {return}
        guard let repsText = repsTextField.text, repsText.count > 0 else {return}
        guard let weight = Double(weightText) else {return}
        guard let reps = Double(repsText) else {return}
        
        let orm = calculateOneRepMax(weight: weight, reps: reps)
        calculateOtherRepMaxes(orm: orm)
        tableView.reloadData()
    }
    
    @IBOutlet weak var repsTextField: UITextField!
    
    @IBAction func repsChanged(_ sender: Any) {
        guard let weightText = weightTextField.text, weightText.count > 0 else {return}
        guard let repsText = repsTextField.text, repsText.count > 0 else {return}
        guard let weight = Double(weightText) else {return}
        guard let reps = Double(repsText) else {return}

        let orm = calculateOneRepMax(weight: weight, reps: reps)
        calculateOtherRepMaxes(orm: orm)
        tableView.reloadData()
    }
    
    
    @IBAction func goButtonTapped(_ sender: Any) {
        repsTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    
    var epley: Double = 0.0
    
    var brzycki: Double = 0.0
    
    var lombardi: Double = 0.0
    
    var currentIndex = 0
    
    
    
    let repMaxes = [
        "1RM",
        "2RM",
        "3RM",
        "4RM",
        "5RM",
        "6RM",
        "7RM",
        "8RM",
        "9RM",
        "10RM"
    ]
    
    var weights: [Double] = [
        116, 109, 106, 103, 100, 97, 95, 93, 91, 88
    ]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repMaxes.count
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        
        Weight.currentWeight = Weight(amount: weights[currentIndex], type: Weight.currentWeight.type)
        
        ViewController.present(from: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PercentTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepPercentageTableViewCell else {fatalError("The dequeued cell is not an instance of MealTableViewCell.")}
        
        
        
        
        cell.percentageLabel.text = repMaxes[indexPath.row]
        cell.weightLabel.text = String(weights[indexPath.row])
        
        cell.backgroundColor = UIColor .black
        cell.textLabel?.textColor = .white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.red
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        
        Weight.currentWeight = Weight(amount: weights[currentIndex], type: Weight.currentWeight.type)
        
        ViewController.present(from: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rep Calculator"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    
    func calculateOneRepMax(weight: Double, reps: Double) -> Double {
        
        
        
        //Epley
        epley = weight * (1 + reps / 30)
        
        //Brzycki
        brzycki = weight * (36 / (37 - reps))
        
        lombardi = weight * pow(reps, 0.10)
        
//        let mcglothin = (100 * weight) / (101.3 - 2.67123 * reps)
        
        
        
        if reps == 1 {
            return weight
        }
        let average = (epley + brzycki + lombardi) / 3.0
        return average.rounded()
    }
    
    
    func calculateOtherRepMaxes(orm: Double) {
        
        weights[0] = orm
        
        for i in 2 ... 10 {
            let l = lombardi / pow(Double(i), 0.10)
            let b = (brzycki * Double(37 - i)) / 36
            let e = epley / ((1 + (Double(i) / 30)))
            let avg = ((l + b + e) / 3).rounded()
            weights[i - 1] = avg
        }
    }

    



}













