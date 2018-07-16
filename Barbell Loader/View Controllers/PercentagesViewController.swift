//
//  PercentagesViewController.swift
//  QuestionBot
//
//  Created by Will Said on 2/10/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class PercentagesViewController: MyViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var increment = 5
    var weight = 200.0
    var currentIndex = 0
    
    // Data model: These strings will be the data for the table view cells
    
    //these are the set percentage amounts, determined by the increment. these are for increment 5
    var setPercentages = [1.00, 0.95, 0.90, 0.85, 0.80, 0.75, 0.70, 0.65, 0.60, 0.55, 0.50]
    var setPercentagesString = ["100%: ", "95%: ", "90%: ", "85%: ", "80%: ", "75%: ", "70%: ", "65%: ", "60%: ", "55%: ", "50%: "]
    
    //the actual weights.
    var weightsArray: [String] = ["100", "95", "90", "85", "80", "75", "70", "65", "60", "55", "50"]
    
    //these are the cells that will be displayed
    var tableWeights = ["100%: 100", "95%: 95", "90%: 90", "85%: ", "80%: ", "75%: ", "70%: ", "65%: ", "60%: ", "55%: ", "50%: "]
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var lbSwitch: UISwitch!
    
    let pickerViewArray = ["1", "5", "10"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: pickerViewArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let i = Int(pickerViewArray[row]) {
            increment = i
            if increment == 1 {
                setPercentages = []
                setPercentagesString = []
                weightsArray = []
                tableWeights = []
                for i in stride(from: 100, through: 50, by: -1) {
                    let dec = Double(i) / 100.0  //like 1.00, 0.95, etc
                    setPercentages.append(dec)
                    setPercentagesString.append(String(i) + "%: ")
                    weightsArray.append(String(i))
                    tableWeights.append(String(i))
                }
                resetTableView(weight)
            } else if increment == 5 {
                setPercentages = [1.00, 0.95, 0.90, 0.85, 0.80, 0.75, 0.70, 0.65, 0.60, 0.55, 0.50]
                setPercentagesString = ["100%: ", "95%: ", "90%: ", "85%: ", "80%: ", "75%: ", "70%: ", "65%: ", "60%: ", "55%: ", "50%: "]
                weightsArray = ["100", "95", "90", "85", "80", "75", "70", "65", "60", "55", "50"]
                tableWeights = ["100%: 100", "95%: 95", "90%: 90", "85%: ", "80%: ", "75%: ", "70%: ", "65%: ", "60%: ", "55%: ", "50%: "]
                
                //then handle actual weights
                resetTableView(weight)
                
            } else if increment == 10 {
                setPercentages = [1.00, 0.90, 0.80, 0.70, 0.60, 0.50]
                setPercentagesString = ["100%: ", "90%: ", "80%: ", "70%: ", "60%: ", "50%: "]
                weightsArray = ["100", "90", "80", "70", "60", "50"]
                tableWeights = ["100%: 100", "90%: 90", "80%: ", "70%: ", "60%: ", "50%: "]
                
                //then handle actual weights
                resetTableView(weight)
                
            }
        }
    }
    

    func resetTableView(_ currentWeight: Double) {
        for i in 0..<weightsArray.count {
            weightsArray[i] = String(Int((currentWeight * setPercentages[i]).rounded()))
            tableWeights[i] = setPercentagesString[i] + weightsArray[i]
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func goWeightField(_ sender: UIButton) {
        if let weights = weightTextField.text {
            if let weightDouble = Double(weights) {
                weight = weightDouble
                resetTableView(weightDouble)
            }
        }
        weightTextField.resignFirstResponder()
    }
    @IBOutlet weak var weightTextField: UITextField!

    @IBAction func weightFieldDidChange(_ sender: UITextField) {
        if let weights = weightTextField.text {
            if let weightDouble = Double(weights) {
                weight = weightDouble
                resetTableView(weightDouble)
            }
        }
    }
    
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightTextField.text = String(weight)
        pickerView.selectRow(1, inComponent: 0, animated: true)
        
        lbSwitch.isOn = Weight.currentWeight.type == .lb

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = true
        
        resetTableView(weight)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableWeights.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            // set the text from the data model
            cell.textLabel?.text = self.tableWeights[indexPath.row]
 
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator

            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.red
            cell.selectedBackgroundView = bgColorView
            cell.selectionStyle = .default
            return cell
        }

        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        
        Weight.currentWeight = Weight(amount: Double(weightsArray[currentIndex])!, type: lbSwitch.isOn ? .lb : .kg)
        
        ViewController.present(from: self)
    }
    
    
    
    
    
    

}
