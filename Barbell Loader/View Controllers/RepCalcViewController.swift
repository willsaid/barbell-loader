//
//  RepCalcViewController.swift
//  QuestionBot
//
//  Created by Will Said on 2/16/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class RepCalcViewController: MyViewController {
    
    
    /// 1RM, 2RM, etc
    var repMaxes: [String] {
        var list = [String]()
        for i in 1 ... 10 {
            list.append(String(i) + "RM")
        }
        return list
    }
    
    ///temporary data source, later updated by RepMax
    var weights: [Double] = [
        116, 109, 106, 103, 100, 97, 95, 93, 91, 88
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rep Calculator"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var repsTextField: UITextField!

    @IBAction func weightChanged(_ sender: Any) {
        processInput()
    }
    
    @IBAction func repsChanged(_ sender: Any) {
        processInput()
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        repsTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }

    
    private func processInput() {
        guard let weightText = weightTextField.text, weightText.count > 0 else {return}
        guard let repsText = repsTextField.text, repsText.count > 0 else {return}
        guard let weight = Double(weightText) else {return}
        guard let reps = Double(repsText) else {return}
        
        self.weights = RepMax(weight: weight, reps: reps).getRepMaxes()
        tableView.reloadData()
    }
    



}





extension RepCalcViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weights.count
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        Weight.currentWeight = Weight(amount: weights[indexPath.row], type: Weight.currentWeight.type)
        
        ViewController.present(from: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PercentTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let cell = cell  as? RepPercentageTableViewCell {
            cell.percentageLabel.text = repMaxes[indexPath.row]
            cell.weightLabel.text = String(weights[indexPath.row])
            
            cell.backgroundColor = UIColor .black
            cell.textLabel?.textColor = .white
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.red
            cell.selectedBackgroundView = bgColorView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Weight.currentWeight = Weight(amount: weights[indexPath.row], type: Weight.currentWeight.type)
        
        ViewController.present(from: self)
    }
}













