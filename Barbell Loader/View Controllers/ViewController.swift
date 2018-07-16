//
//  VideoViewController.swift
//  QuestionBot
//
//  Created by Will Said on 9/1/18
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit




class ViewController: MyViewController, UIPickerViewDelegate, UIScrollViewDelegate {
    
    
    
    // MARK: - PRESENTATION
    
    static func present(from source: UIViewController) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loaderViewController") as? ViewController {
            
            source.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    // MARK: - Segue Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPercentages", let percentPage = segue.destination as? PercentagesViewController {
            percentPage.weight = Weight.currentWeight.amount
        }
    }
    
    
    
    
    
    
    
    
    //MARK: - CLASS VARIABLES
    
    var needPlatesLabelOnStart = ""
    
    var UIimageArray = [UIImage]()
    
    
    
    
    
    
    
    
    
    // MARK: - LIFECYCLE
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (justResetbarWeight) {
            optimize()
            justResetbarWeight = false
        }
    }
 
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 300, height: 875)
        imageScrollView.contentSize = CGSize(width: 7000, height: 5000)
        
        needMorePlatesLabel.text = needPlatesLabelOnStart
        
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 5.0
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        
        if Weight.currentWeight.pounds == 44 || Weight.currentWeight.kilograms == 20 {
            Weight.currentWeight = Weight(amount: 45, type: .lb)
        }
        respondToQuestion(newQuestion: Weight.currentWeight.toString, newKilo: Weight.currentWeight.type == .kg, isPlateButton: false, resetBar: true, platePushed: "", takeOffPlate: false)
    }

    
    
    
    
    
    
    
    
    //MARK: - IB OUTLETS
    
    @IBOutlet weak var logThisWeight: UIButton!
    @IBOutlet weak var needMorePlatesLabel: UILabel!
    @IBOutlet weak var resetbutton45pounds: UIButton!
    @IBOutlet weak var responseLabel: UILabel?
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var poundButton: UIButton!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var plateScrollViewStackView: UIStackView!
    @IBOutlet weak var imageScrollView: UIScrollView!

    @IBOutlet weak var fortyfivebutton: UIButton!
    @IBOutlet weak var thirtyfivebutton: UIButton!
    @IBOutlet weak var twentyfivebutton: UIButton!
    @IBOutlet weak var tenpoundbutton: UIButton!
    @IBOutlet weak var fivepoundbutton: UIButton!
    @IBOutlet weak var twoandhalfbutton: UIButton!
    @IBOutlet weak var quarterpoundplate: UIButton!
    @IBOutlet weak var onepoundplate: UIButton!
    @IBOutlet weak var halfpoundplate: UIButton!
    @IBOutlet weak var threequarterpoundplate: UIButton!
    
    @IBOutlet weak var bigRedButton: UIButton!
    @IBOutlet weak var bigbluebutton: UIButton!
    @IBOutlet weak var bigyellowbutton: UIButton!
    @IBOutlet weak var biggreenbutton: UIButton!
    @IBOutlet weak var bigwhitebutton: UIButton!
    @IBOutlet weak var littleredbutton: UIButton!
    @IBOutlet weak var littlebluebutton: UIButton!
    @IBOutlet weak var littleyellowbutton: UIButton!
    @IBOutlet weak var littlegreenbutton: UIButton!
    @IBOutlet weak var littlewhitebutton: UIButton!
    @IBOutlet weak var quarterkilobutton: UIButton!

    @IBOutlet weak var customButton: UIButton?
    @IBOutlet weak var customButton2: UIButton!
    @IBOutlet weak var collarButton: UIButton!
    @IBOutlet weak var switchBarButton: UIButton!



    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - IB FUNCTIONS
    
    @IBAction func undoTapped(_ sender: UIButton) {
        delete()
    }

    @IBAction func logThisWeightIsTapped(_ sender: UIButton) {
        Log.log(weight: Weight.currentWeight)
    }
    
    @IBAction func questionChanged(_ sender: UITextField) {
        guard let t = questionField.text, t.count > 0 else {return}
        guard let textNumber = Double(t) else {return}
        let text = String(textNumber)
        respondToQuestion(newQuestion: text, newKilo: Weight.currentWeight.type == .kg, isPlateButton: false, resetBar: false, platePushed: "", takeOffPlate: false)
    }
    
    
    
    @IBAction func switchBarButtonTapped(_ sender: UIButton) {
        let q = Weight.currentWeight.converted.toString
        respondToQuestion(newQuestion: q, newKilo: Weight.currentWeight.type != .kg, isPlateButton: false, resetBar: false, platePushed: "", takeOffPlate: false)
    }
    
    
    @IBAction func optimize() {
        respondToQuestion(newQuestion: String(Weight.currentWeight.amount), newKilo: Weight.currentWeight.type == .kg, isPlateButton: false, resetBar: false, platePushed: "", takeOffPlate: false)
    }
    
    
    
    @IBAction func reset(_ sender: UIButton?) {
        reset()
    }
    
    
    
    @IBAction func collarButtonPressed(_ sender: UIButton) {
        if collarButton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "weighted2.5kgcollar"))
            respondToQuestion(newQuestion: "5", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "", takeOffPlate: false)
        }
    }
    
    
    @IBAction func customButtonPressed(_ sender: UIButton) {
        if customButton?.isTouchInside == true {
            if customWeightKg == true {
                if customWeight >= 10 {
                    UIimageArray.append(#imageLiteral(resourceName: "customPlate"))
                } else {
                    UIimageArray.append(#imageLiteral(resourceName: "littlecustomplate"))
                }
            } else {
                if customWeight >= 45 {
                    UIimageArray.append(#imageLiteral(resourceName: "customPlate"))
                } else {
                    UIimageArray.append(#imageLiteral(resourceName: "littlecustomplate"))
                }
            }
            
            respondToQuestion(newQuestion: String(customWeight * 2.0), newKilo: customWeightKg, isPlateButton: true, resetBar: false, platePushed: "", takeOffPlate: false)
        }
    }
    
    @IBAction func customButton2Pressed(_ sender: UIButton) {
        if customButton2?.isTouchInside == true {
            if customWeightKg2 == true {
                if customWeight2 >= 10 {
                    UIimageArray.append(#imageLiteral(resourceName: "customPlate-1"))
                } else {
                    UIimageArray.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                }
            } else {
                if customWeight2 >= 45 {
                    UIimageArray.append(#imageLiteral(resourceName: "customPlate-1"))
                } else {
                    UIimageArray.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                }
            }
            
            respondToQuestion(newQuestion: String(customWeight2 * 2.0), newKilo: customWeightKg2, isPlateButton: true, resetBar: false, platePushed: "", takeOffPlate: false)
        }
    }
    
    /// KG BUTTON
    @IBAction func askButtonTapped(_ sender: AnyObject) {
        
        evaluateInput(type: .kg)
    }
    
    @IBAction func poundButtonTapped(_ sender: AnyObject) {
        
        evaluateInput(type: .lb)
    }
    
    
    
    
    
    
    //MARK: - PLATE BUTTON IB FUNCTIONS
    
    @IBAction func fortyfiveplate(_ sender: UIButton) {
        if fortyfivebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "fortyfive"))
            respondToQuestion(newQuestion: "90", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "fortyfive", takeOffPlate: false)
            
        }
    }
    
    @IBAction func thirtyfiveplate(_ sender: UIButton) {
        if thirtyfivebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "thirtyfiveplate"))
            respondToQuestion(newQuestion: "70", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "thirtyfive", takeOffPlate: false)
            
        }
    }
    
    @IBAction func twentyfiveplate(_ sender: UIButton) {
        if twentyfivebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "twentyfive"))
            respondToQuestion(newQuestion: "50", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "twentyfive", takeOffPlate: false)
            
        }
    }
    
    @IBAction func tenpoundplate(_ sender: UIButton) {
        if tenpoundbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "ten"))
            respondToQuestion(newQuestion: "20", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "ten", takeOffPlate: false)
            
        }
    }
    
    @IBAction func fivepoundplate(_ sender: UIButton) {
        if fivepoundbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "five"))
            respondToQuestion(newQuestion: "10", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "five", takeOffPlate: false)
            
        }
    }
    @IBAction func twoandhalfplate(_ sender: UIButton) {
        if twoandhalfbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "twohalf"))
            respondToQuestion(newQuestion: "5", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "twohalf", takeOffPlate: false)
            
        }
    }
    
    @IBAction func onepoundplatetouched(_ sender: UIButton) {
        if onepoundplate.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "onepound"))
            respondToQuestion(newQuestion: "2", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "onepound", takeOffPlate: false)
            
        }
    }
    
    @IBAction func threequartertapped(_ sender: UIButton) {
        if threequarterpoundplate.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "threequarterplate"))
            respondToQuestion(newQuestion: "1.5", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "threequarters", takeOffPlate: false)
            
        }
    }
    
    @IBAction func halfpoundplatetapped(_ sender: UIButton) {
        if halfpoundplate.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "halfpoundplate"))
            respondToQuestion(newQuestion: "1", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "halfpound", takeOffPlate: false)
            
        }
    }
    
    @IBAction func quarterpoundplatetapped(_ sender: UIButton) {
        if quarterpoundplate.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "quarterpoundplate"))
            respondToQuestion(newQuestion: "0.5", newKilo: false, isPlateButton: true, resetBar: false, platePushed: "quarterpound", takeOffPlate: false)
            
        }
    }
    
    
    
    
    
    
    
    @IBAction func bigredplate(_ sender: UIButton) {
        if bigRedButton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "bigRed"))
            //
            respondToQuestion(newQuestion: "50", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "bigred", takeOffPlate: false)
            //
        }
        
    }
    
    @IBAction func bigblueplate(_ sender: UIButton) {
        if bigbluebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "bigBlue"))
            respondToQuestion(newQuestion: "40", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "bigblue", takeOffPlate: false)
            
        }
    }
    
    @IBAction func bigyellowplate(_ sender: UIButton) {
        if bigyellowbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "bigYellow"))
            respondToQuestion(newQuestion: "30", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "bigyellow", takeOffPlate: false)
            
        }
    }
    
    @IBAction func biggreenplate(_ sender: UIButton) {
        if biggreenbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "bigGreen"))
            respondToQuestion(newQuestion: "20", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "biggreen", takeOffPlate: false)
            
        }
    }
    
    @IBAction func bigwhiteplate(_ sender: UIButton) {
        if bigwhitebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "white"))
            respondToQuestion(newQuestion: "10", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "bigwhite", takeOffPlate: false)
            
        }
    }
    
    @IBAction func littleredplate(_ sender: UIButton) {
        if littleredbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "littleRed"))
            respondToQuestion(newQuestion: "5", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "littlered", takeOffPlate: false)
            
        }
    }
    
    @IBAction func littleblueplate(_ sender: UIButton) {
        if littlebluebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "littleBlue"))
            respondToQuestion(newQuestion: "4", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "littleblue", takeOffPlate: false)
            
        }
    }
    
    @IBAction func littleyellowplate(_ sender: UIButton) {
        if littleyellowbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "littleYellow"))
            respondToQuestion(newQuestion: "3", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "littleyellow", takeOffPlate: false)
            
        }
    }
    
    @IBAction func littlegreenplate(_ sender: UIButton) {
        if littlegreenbutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "littleGreen"))
            respondToQuestion(newQuestion: "2", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "littlegreen", takeOffPlate: false)
            
        }
    }
    
    @IBAction func littlewhiteplate(_ sender: UIButton) {
        if littlewhitebutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "littleWhite"))
            respondToQuestion(newQuestion: "1", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "littlewhite", takeOffPlate: false)
            
        }
    }
    
    @IBAction func quarterkiloplate(_ sender: UIButton) {
        if quarterkilobutton.isTouchInside == true {
            UIimageArray.append(#imageLiteral(resourceName: "powerquarterkilo"))
            respondToQuestion(newQuestion: "0.5", newKilo: true, isPlateButton: true, resetBar: false, platePushed: "quarterkilo", takeOffPlate: false)
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - HELPER FUNCTIONS

    /// remove outermost plates
    func delete() {
        if !UIimageArray.isEmpty {
            UIimageArray.removeLast()
            removeAllWeights()
            showWeights()
            var lastWeight = WeightHistory.sharedInstance.pop()
            if lastWeight == Weight.currentWeight {
                //first time hitting delete
                lastWeight = WeightHistory.sharedInstance.pop()
            }
            if lastWeight.type == .kg {
                let pounds = Weight(amount: lastWeight.pounds, type: .lb)
                responseLabel?.text = "\(lastWeight.toString) kg  (\(pounds.toString) lb)"
            } else {
                let kg = Weight(amount: lastWeight.kilograms, type: .kg)
                responseLabel?.text = "\(lastWeight.toString) lb  (\(kg.toString) kg)"
            }
            
            Weight.currentWeight = lastWeight
        }
    }
    
    func viewForZooming(in imageScrollView: UIScrollView) -> UIView? {
        return stackView
    }
    
    func evaluateInput(type: WeightType) {
        if let text = questionField.text, Weight(amount: text, type: type) != nil {
            
            respondToQuestion(newQuestion: text, newKilo: type == .kg, isPlateButton: false, resetBar: false, platePushed: "", takeOffPlate: false)
            
        } else {
            //swap them. so if its currently showing 45 kg, and lb is pushed, show 45 lb.
            respondToQuestion(newQuestion: Weight.currentWeight.toString, newKilo: Weight.currentWeight.type != .kg, isPlateButton: false, resetBar: false, platePushed: "", takeOffPlate: false)
            
            questionField.text = ""
            
        }
        
        questionField.resignFirstResponder()
    }
    
    func displayAnswerTextOnScreen(_ answer: String?) {
        if responseLabel?.text != nil {
            responseLabel?.text = answer
        }
    }
     
    func reset() {
        questionField.text = ""
        UIimageArray = []
        if barWeightKg == true {
            if isThisCollarsSwitchOn == true {
                respondToQuestion(newQuestion: String(Int((barweightstartingat45 * 0.45359237).rounded()) + 5), newKilo: true, isPlateButton: false, resetBar: true, platePushed: "", takeOffPlate: false)
            } else {
                respondToQuestion(newQuestion: String(Int((barweightstartingat45 * 0.45359237).rounded())), newKilo: true, isPlateButton: false, resetBar: true, platePushed: "", takeOffPlate: false)
            }
        } else {
            if isThisCollarsSwitchOn == true {
                respondToQuestion(newQuestion: String(barweightstartingat45 + 11), newKilo: false, isPlateButton: false, resetBar: true, platePushed: "", takeOffPlate: false)
            } else {
                respondToQuestion(newQuestion: String(barweightstartingat45), newKilo: false, isPlateButton: false, resetBar: true, platePushed: "", takeOffPlate: false)
            }
        }
    }
    
    func setWeightFromPlateButton(question: String, kilo: Bool) -> String {
        //append button plate's image to old ui image array and pass in new variable that doesnt print out ui image
        
        let weight = Weight.currentWeight
        let newWeight = Weight(amount: question, type: kilo ? .kg : .lb)
        var sum = weight + newWeight! //this is in pounds
        
        if weight.type == .kg && !kilo {
            sum = sum + Weight(amount: 1, type: .lb)
        }
        
        if kilo {
            return sum.converted.toString
        }
        return sum.toString
    }
    
    func resetBarWeightIfNecessary(kilo: Bool) {
        //reset bar weight if necessary
        if kilo && (barweightstartingat45 == 45 || Weight.currentWeight.amount == 45) {
            barweightstartingat45 = 44
            defaults.set(44, forKey: "barweight")
            barWeightKg = true
            defaults.set(true, forKey: "barweightkg")
            
        } else if !kilo && (barweightstartingat45 == 44 || Weight.currentWeight.amount == 44) {
            barweightstartingat45 = 45
            defaults.set(45, forKey: "barweight")
            barWeightKg = false
            defaults.set(false, forKey: "barweightkg")
            
        }
    }
    
    func loadBar(question: String, newKilo: Bool) {
        if (newKilo == false && Double(question)! >= barweightstartingat45)
            || (newKilo == true && Double(question)! >= barweightstartingat45 * conversionDecimal)
            || (isThisCollarsSwitchOn == true && newKilo == false && Double(question)! >= barweightstartingat45 + 11)
            || ((isThisCollarsSwitchOn == true) && (newKilo == true) && (Double(question)! >= barweightstartingat45 * conversionDecimal + 5))
        {
            
            showWeights()
            
        }
    }
    
    ///displays plates on bar
    func showWeights() {
        func add(weight: UIImage) {
            let imageView = UIImageView()
            imageView.image = weight
            if let s = stackView {
                s.addArrangedSubview(imageView)
            }
            imageView.contentMode = .scaleAspectFit
        }
        
        
        UIimageArray.insert(#imageLiteral(resourceName: "barbell"), at: 0)
        
        for weightImage in UIimageArray.reversed() {
            add(weight: weightImage)
        }
        
        UIimageArray.remove(at: 0)
        
        for weightImage in UIimageArray {
            add(weight: weightImage)
        }
    }
    
    func removeAllWeights() {
        if let sview = stackView {
            for view in sview.arrangedSubviews {
                view.removeFromSuperview()
            }
        }
    }
    
    func leftoverChange(kilo: Bool, question: String) {
        if kilo == true && returnChange >= 0.5 {
            if returnChange < Double(Int.max) {
                needPlatesLabelOnStart = String((returnChange * 10).rounded() / 10.0) + "kg leftover"
                if let n = needMorePlatesLabel {
                    n.text = "Need more plates: " + needPlatesLabelOnStart
                }
                print("areturn change: " + String(returnChange))
                print("needPlatesLabelOnStart: " + String(needPlatesLabelOnStart))
            } else {
                needPlatesLabelOnStart = String((returnChange * 10).rounded() / 10.0) + "kg leftover"
                needMorePlatesLabel.text = "Need more plates: " + needPlatesLabelOnStart
                print("breturn change: " + String(returnChange))
                print("needPlatesLabelOnStart: " + String(needPlatesLabelOnStart))
            }
            
        } else if kilo == false && returnChangelb >= 1 {
            if returnChangelb < Double(Int.max) {
                needPlatesLabelOnStart = String((returnChangelb * 10).rounded() / 10.0) + "lb leftover"
                needMorePlatesLabel.text = "Need more plates: " + needPlatesLabelOnStart
                print("creturn change: " + String(returnChangelb))
                print("needPlatesLabelOnStart: " + String(needPlatesLabelOnStart))
            } else {
                needPlatesLabelOnStart = String((returnChangelb * 10).rounded() / 10.0) + "lb leftover"
                needMorePlatesLabel.text = "Need more plates: " + needPlatesLabelOnStart
                print("dreturn change: " + String(returnChangelb))
                print("needPlatesLabelOnStart: " + String(needPlatesLabelOnStart))
            }
            
        } else {
            needPlatesLabelOnStart = ""
            needMorePlatesLabel.text = needPlatesLabelOnStart
            print("ereturn change: " + String(returnChange))
            print("needPlatesLabelOnStart: " + String(needPlatesLabelOnStart))
        }
        
        if (kilo == false && Double(question)! < barweightstartingat45)
            || (kilo == true && Double(question)! < barweightstartingat45 * conversionDecimal)
        {
            needMorePlatesLabel.text = "This is less than the bar weight!"
        } else if ((isThisCollarsSwitchOn == true && kilo == false && Double(question)! < barweightstartingat45 + 11)
            || ((isThisCollarsSwitchOn == true) && (kilo == true) && (Double(question)! < barweightstartingat45 * conversionDecimal + 5))) {
            needMorePlatesLabel.text = "This is less than the bar weight with collars!"
        }
        returnChange = 0.0
        
    }
    
    
    
    
    
    func respondToQuestion(newQuestion: String, newKilo: Bool, isPlateButton: Bool, resetBar: Bool, platePushed: String, takeOffPlate: Bool) {
        
        guard let q = Double(newQuestion) else {return}
        let question: String
        let kilo = newKilo
        
        if isPlateButton {
            question = setWeightFromPlateButton(question: String(q), kilo: kilo)
        } else {
            question = String(q)
        }
        
        resetBarWeightIfNecessary(kilo: kilo)
        
        let answer = MyQuestionAnswerer(question: question, kilosToPounds: kilo, barWeight: barweightstartingat45, collars: isThisCollarsSwitchOn).response()
        
        

        displayAnswerTextOnScreen(answer.0)
        
        removeAllWeights()
        
        
        if !isPlateButton {
            UIimageArray = []
        
            for weightImage in answer.1 {
                UIimageArray.append(weightImage)
            }
        }
        
        
        loadBar(question: question, newKilo: newKilo)
        
        leftoverChange(kilo: kilo, question: question)
        
        let weight = Weight(amount: question, type: newKilo ? .kg : .lb)!
        
        Weight.currentWeight = weight
        
        WeightHistory.sharedInstance.add(weight: weight)
        
        imageScrollView.zoomScale = 1
        
        RequestReview.request()
    }
    
    
    
    
    
    
    



}
















