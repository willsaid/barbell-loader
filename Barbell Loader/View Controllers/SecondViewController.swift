//
//  SecondViewController.swift
//  QuestionBot
//
//  Created by Will Said on 11/8/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

//var myMutableString = NSMutableAttributedString()

//global variables

//var firstOpened = true



var customWeight = defaults.double(forKey: "customWeight")
var customWeightKg = defaults.bool(forKey: "customkg")

var customWeight2 = defaults.double(forKey: "customWeight2")
var customWeightKg2 = defaults.bool(forKey: "customkg2")

let conversionDecimal = 0.45359237

var returnChange = 0.0
var returnChangelb = 0.0


var isThereChange = false

var isThisCollarsSwitchOn = defaults.bool(forKey: "collars")

//var barweightstartingat45 = 45.0

var oldResetText = String(Int((barweightstartingat45 * conversionDecimal).rounded()))

var barweightstartingat45 = defaults.double(forKey: "barweight")
var newBarWeight = barweightstartingat45

//var barWeightKg = false
var barWeightKg = defaults.bool(forKey: "barweightkg")



var justResetbarWeight = false



let defaults = UserDefaults.standard

var useBothPlates = defaults.bool(forKey: "useBothPlates")

var oldDate = defaults.string(forKey: "oldDate")

var howManyTimesOpenedApp = defaults.integer(forKey: "timesOpened")
var hasReviewed = defaults.bool(forKey: "hasReviewed")

var bigRedInventory = defaults.integer(forKey: "bigReds")
var bigBlueInventory = defaults.integer(forKey: "bigBlues")
var bigYellowInventory = defaults.integer(forKey: "bigYellows")
var bigGreenInventory = defaults.integer(forKey: "bigGreens")
var bigWhiteInventory = defaults.integer(forKey: "bigWhites")
var littleRedInventory = defaults.integer(forKey: "littleReds")
var littleBlueInventory = defaults.integer(forKey: "littleBlues")
var littleYellowInventory = defaults.integer(forKey: "littleYellows")
var littleGreenInventory = defaults.integer(forKey: "littleGreens")
var littleWhiteInventory = defaults.integer(forKey: "littleWhites")
var powerQuarterInventory = defaults.integer(forKey: "quarterKilos")

var fortyfiveinventory = defaults.integer(forKey: "fortyfives")
var thirtyfiveinventory = defaults.integer(forKey: "thirtyfives")
var twentyfiveinventory = defaults.integer(forKey: "twentyfives")
var teninventory = defaults.integer(forKey: "tens")
var fiveinventory = defaults.integer(forKey: "fives")
var twohalfinventory = defaults.integer(forKey: "twohalves")
var onepoundinventory = defaults.integer(forKey: "onepounds")
var threequartersinventory = defaults.integer(forKey: "threequarters")
var onehalfinventory = defaults.integer(forKey: "onehalves")
var onequarterinventory = defaults.integer(forKey: "onequarters")

var customInventory = defaults.integer(forKey: "custom")
//var customKg = defaults.bool(forKey: "customkg")

var customInventory2 = defaults.integer(forKey: "custom2")
//var customKg2 = defaults.bool(forKey: "customkg2")



class SecondViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var useBothLbandKgSwitch: UISwitch!
    
    @IBAction func useBothSwitchChanged(_ sender: UISwitch) {
        if useBothLbandKgSwitch.isOn {
            useBothPlates = true
            defaults.set(true, forKey: "useBothPlates")
            justResetbarWeight = true
        } else {
            useBothPlates = false
            defaults.set(false, forKey: "useBothPlates")
            justResetbarWeight = true
        }
    }
    
    
    
    
    
    @IBOutlet weak var customButtonInventory: UIButton!
    
    @IBOutlet weak var customButtonInventory2: UIButton!
    
    func settings() -> Bool {
        
//        defaults.register(defaults: ["bigReds" : 100])
//        if UserDefaults.standard.value(forKey: "bigReds") == nil {
//            UserDefaults.standard.set(100, forKey: "bigReds")
//        }
        
        defaults.set(20, forKey: "bigReds")
        defaults.set(2, forKey: "bigBlues")
        defaults.set(2, forKey: "bigYellows")
        defaults.set(2, forKey: "bigGreens")
        defaults.set(2, forKey: "bigWhites")
        defaults.set(2, forKey: "littleReds")
        defaults.set(2, forKey: "littleBlues")
        defaults.set(2, forKey: "littleYellows")
        defaults.set(2, forKey: "littleGreens")
        defaults.set(2, forKey: "littleWhites")
        defaults.set(0, forKey: "quarterKilos")

        defaults.set(20, forKey: "fortyfives")
        defaults.set(0, forKey: "thrityfives")
        defaults.set(2, forKey: "twentyfives")
        defaults.set(2, forKey: "tens")
        defaults.set(2, forKey: "fives")
        defaults.set(2, forKey: "twohalves")
        defaults.set(0, forKey: "onepounds")
        defaults.set(0, forKey: "threequarters")
        defaults.set(0, forKey: "onehalves")
        defaults.set(0, forKey: "onequarters")
        defaults.set(0, forKey: "custom")
        defaults.set(false, forKey: "customkg")
        defaults.set(0.0, forKey: "customWeight")
        
        defaults.set(false, forKey: "customkg2")
        defaults.set(0.0, forKey: "customWeight2")
        
        defaults.set(45.0, forKey: "barweight")
        defaults.set(false, forKey: "barweightkg")
        
        defaults.set("Edit me!\n", forKey: "weightsLogged")

        defaults.synchronize()
        
        return true
    }

   
    lazy var settingsfunc = settings()
    
    func setInventories() -> Bool {
        
        useBothPlates = defaults.bool(forKey: "useBothPlates")
        
        bigRedInventory = defaults.integer(forKey: "bigReds")
        bigBlueInventory = defaults.integer(forKey: "bigBlues")
        bigYellowInventory = defaults.integer(forKey: "bigYellows")
        bigGreenInventory = defaults.integer(forKey: "bigGreens")
        bigWhiteInventory = defaults.integer(forKey: "bigWhites")
        littleRedInventory = defaults.integer(forKey: "littleReds")
        littleBlueInventory = defaults.integer(forKey: "littleBlues")
        littleYellowInventory = defaults.integer(forKey: "littleYellows")
        littleGreenInventory = defaults.integer(forKey: "littleGreens")
        littleWhiteInventory = defaults.integer(forKey: "littleWhites")
        powerQuarterInventory = defaults.integer(forKey: "quarterKilos")

        fortyfiveinventory = defaults.integer(forKey: "fortyfives")
        thirtyfiveinventory = defaults.integer(forKey: "thirtyfives")
        twentyfiveinventory = defaults.integer(forKey: "twentyfives")
        teninventory = defaults.integer(forKey: "tens")
        fiveinventory = defaults.integer(forKey: "fives")
        twohalfinventory = defaults.integer(forKey: "twohalves")
        onepoundinventory = defaults.integer(forKey: "onepounds")
        threequartersinventory = defaults.integer(forKey: "threequarters")
        onehalfinventory = defaults.integer(forKey: "onehalves")
        onequarterinventory = defaults.integer(forKey: "onequarters")
        
        customInventory = defaults.integer(forKey: "custom")
        customWeightKg = defaults.bool(forKey: "customkg")
        customWeight = defaults.double(forKey: "customWeight")
        
        customWeightKg2 = defaults.bool(forKey: "customkg")
        customWeight2 = defaults.double(forKey: "customWeight")
        return true
    }
//
    lazy var setinventoriesfunc = setInventories()

    
    @IBOutlet weak var bigredstepper: UIStepper!
    
    @IBAction func bigredsteppervaluechanged(_ sender: UIStepper) {
        bigredinventorylabel.text = Int(sender.value).description
        bigRedInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "bigReds")
        justResetbarWeight = true
    }
    
    @IBOutlet weak var bigredinventorylabel: UILabel!
    
    
    
    @IBOutlet weak var bigbluestepper: UIStepper!
    @IBAction func bigbluesteppervaluechanged(_ sender: UIStepper) {
        bigblueinventorylabel.text = Int(sender.value).description
        bigBlueInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "bigBlues")
        justResetbarWeight = true
    }
    @IBOutlet weak var bigblueinventorylabel: UILabel!
    
    
   
    @IBOutlet weak var bigyellowstepper: UIStepper!
    @IBAction func bigyellowsteppervaluechanged(_ sender: UIStepper) {
        bigyellowinventorylabel.text = Int(sender.value).description
        bigYellowInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "bigYellows")
        justResetbarWeight = true
    }
    @IBOutlet weak var bigyellowinventorylabel: UILabel!
    
    
    
    @IBOutlet weak var biggreenstepper: UIStepper!
    @IBAction func biggreensteppervaluechanged(_ sender: UIStepper) {
        biggreeninventorylabel.text = Int(sender.value).description
        bigGreenInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "bigGreens")
        justResetbarWeight = true
    }
    @IBOutlet weak var biggreeninventorylabel: UILabel!
    
    
    
    @IBOutlet weak var bigwhitestepper: UIStepper!
    
    @IBAction func bigwhitesteppervaluechanged(_ sender: UIStepper) {
        bigwhiteinventorylabel.text = Int(sender.value).description
        bigWhiteInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "bigWhites")
        justResetbarWeight = true
    }
    @IBOutlet weak var bigwhiteinventorylabel: UILabel!
    
    
   
    @IBOutlet weak var littleredstepper: UIStepper!
    @IBAction func littleredstepperchanged(_ sender: UIStepper) {
        littleredinventorylabel.text = Int(sender.value).description
        littleRedInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "littleReds")
        justResetbarWeight = true

    }
    @IBOutlet weak var littleredinventorylabel: UILabel!
    
    
    @IBOutlet weak var littlebluestepper: UIStepper!
    @IBAction func littlebluestepperchanged(_ sender: UIStepper) {
        littleblueinventorylabel.text = Int(sender.value).description
        littleBlueInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "littleBlues")
        justResetbarWeight = true

    }
    @IBOutlet weak var littleblueinventorylabel: UILabel!
    
    
    @IBOutlet weak var littleyellowstepper: UIStepper!
    @IBAction func littleyellowstepperchanged(_ sender: UIStepper) {
        littleyellowlabel.text = Int(sender.value).description
        littleYellowInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "littleYellows")
        justResetbarWeight = true

    }
    @IBOutlet weak var littleyellowlabel: UILabel!
    
    
    
    @IBOutlet weak var littlegreenstepper: UIStepper!
    @IBAction func littlegreenstepperchanged(_ sender: UIStepper) {
        littlegreenlabel.text = Int(sender.value).description
        littleGreenInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "littleGreens")
        justResetbarWeight = true
    }
    @IBOutlet weak var littlegreenlabel: UILabel!
    
    
    
    @IBOutlet weak var littlewhitestepper: UIStepper!
    @IBAction func littlewhitestepperchanged(_ sender: UIStepper) {
        littlewhitelabel.text = Int(sender.value).description
        littleWhiteInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "littleWhites")
        justResetbarWeight = true

    }
    @IBOutlet weak var littlewhitelabel: UILabel!
    
    
    
    
    @IBOutlet weak var powerquarterstepper: UIStepper!
    @IBAction func powerquarterstepperchanged(_ sender: UIStepper) {
        powerquarterlabel.text = Int(sender.value).description
        powerQuarterInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "quarterKilos")
        justResetbarWeight = true

    }
    @IBOutlet weak var powerquarterlabel: UILabel!
    
    
    
    @IBOutlet weak var customStepper: UIStepper!
    @IBAction func customStepperChanged(_ sender: UIStepper) {
        customLabel.text = Int(sender.value).description
        customInventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "custom")
        justResetbarWeight = true
    }
    
    @IBOutlet weak var customLabel: UILabel!
    
    
    @IBOutlet weak var customLabelDescribingWeight: UILabel!
    
    
    
    
    

    @IBOutlet weak var customStepper2: UIStepper!
    
    @IBAction func customStepper2Changed(_ sender: UIStepper) {
        customLabel2.text = Int(sender.value).description
        customInventory2 = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "custom2")
        justResetbarWeight = true
    }
    
    @IBOutlet weak var customLabel2: UILabel!
    
    
    
    
    
    
    @IBOutlet weak var fortyfivestepper: UIStepper!
    @IBAction func fortyfivestepperchanged(_ sender: UIStepper) {
        fortyfivelabel.text = Int(sender.value).description
        fortyfiveinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "fortyfives")
        justResetbarWeight = true

    }
    @IBOutlet weak var fortyfivelabel: UILabel!
    
    @IBOutlet weak var thirtyfivestepper: UIStepper!
    @IBAction func thirtyfivestepperchanged(_ sender: UIStepper) {
        thirtyfivelabel.text = Int(sender.value).description
        thirtyfiveinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "thirtyfives")
        justResetbarWeight = true

    }
    @IBOutlet weak var thirtyfivelabel: UILabel!
    
    @IBOutlet weak var twentyfivestepper: UIStepper!
    @IBAction func twentyfivestepperchanged(_ sender: UIStepper) {
        twentyfivelabel.text = Int(sender.value).description
        twentyfiveinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "twentyfives")
        justResetbarWeight = true

    }
    @IBOutlet weak var twentyfivelabel: UILabel!
    
    
    @IBOutlet weak var tenstepper: UIStepper!
    @IBAction func tenstepperchanged(_ sender: UIStepper) {
        tenlabel.text = Int(sender.value).description
        teninventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "tens")
        justResetbarWeight = true

    }
    @IBOutlet weak var tenlabel: UILabel!
    
    
    @IBOutlet weak var fivestepper: UIStepper!
    @IBAction func fivestepperchanged(_ sender: UIStepper) {
        fivelabel.text = Int(sender.value).description
        fiveinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "fives")
        justResetbarWeight = true

    }
    @IBOutlet weak var fivelabel: UILabel!
    
    
    @IBOutlet weak var twohalfstepper: UIStepper!
    @IBAction func twohalfstepperchanged(_ sender: UIStepper) {
        twohalflabel.text = Int(sender.value).description
        twohalfinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "twohalves")
        justResetbarWeight = true

    }
    @IBOutlet weak var twohalflabel: UILabel!
    
    
    @IBOutlet weak var onepoundstepper: UIStepper!
    @IBAction func onepoundstepperchanged(_ sender: UIStepper) {
        onepoundlabel.text = Int(sender.value).description
        onepoundinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "onepounds")
        justResetbarWeight = true

    }
    @IBOutlet weak var onepoundlabel: UILabel!
    
    @IBOutlet weak var threequarterstepper: UIStepper!
    @IBAction func threequarterstepperchanged(_ sender: UIStepper) {
        threequarterlabel.text = Int(sender.value).description
        threequartersinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "threequarters")
        justResetbarWeight = true

    }
    @IBOutlet weak var threequarterlabel: UILabel!
    
    
    @IBOutlet weak var halfpoundstepper: UIStepper!
    @IBAction func halfpoundstepperchanged(_ sender: UIStepper) {
        halfpoundlabel.text = Int(sender.value).description
        onehalfinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "onehalves")
        justResetbarWeight = true

    }
    @IBOutlet weak var halfpoundlabel: UILabel!
    
    
    @IBOutlet weak var quarterpoundstepper: UIStepper!
    @IBAction func quarterpoundstepperchanged(_ sender: UIStepper) {
        quarterpoundlabel.text = Int(sender.value).description
        onequarterinventory = Int(Int(sender.value).description)!
        defaults.set(Int(Int(sender.value).description)!, forKey: "onequarters")
        justResetbarWeight = true

    }
    @IBOutlet weak var quarterpoundlabel: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var inventoryScrollView: UIScrollView!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        
        self.hideKeyboard()
        
//        var setinventoriesfunc = setInventories()
        defaults.register(defaults: ["bigReds" : 20])
        defaults.register(defaults: ["bigBlues" : 2])
        defaults.register(defaults: ["bigYellows" : 2])
        defaults.register(defaults: ["bigGreens" : 2])
        defaults.register(defaults: ["bigWhites" : 2])
        defaults.register(defaults: ["littleReds" : 2])
        defaults.register(defaults: ["littleBlues" : 2])
        defaults.register(defaults: ["littleYellows" : 2])
        defaults.register(defaults: ["littleGreens" : 2])
        defaults.register(defaults: ["littleWhites" : 2])
        defaults.register(defaults: ["quarterKilos" : 0])
        defaults.register(defaults: ["fortyfives" : 20])
        defaults.register(defaults: ["thirtyfives" : 0])
        defaults.register(defaults: ["twentyfives" : 2])
        defaults.register(defaults: ["tens" : 4])
        defaults.register(defaults: ["fives" : 2])
        defaults.register(defaults: ["twohalves" : 2])
        defaults.register(defaults: ["onepounds" : 0])
        defaults.register(defaults: ["threequarters" : 0])
        defaults.register(defaults: ["onehalves" : 0])
        defaults.register(defaults: ["onequarters" : 0])
        defaults.register(defaults: ["custom" : 0])
        defaults.register(defaults: ["customkg" : false])
        defaults.register(defaults: ["custom2" : 0])
        defaults.register(defaults: ["customkg2" : false])
        defaults.register(defaults: ["barweight" : 45.0])
        defaults.register(defaults: ["customWeight" : 0.0])
        defaults.register(defaults: ["customWeight2" : 0.0])
        

        if Double(customWeight).rounded() == Double(customWeight) {
            if customWeightKg == true {
                customButtonInventory.setTitle(String(Int(customWeight)) + " kg", for: .normal)
            } else {
                customButtonInventory.setTitle(String(Int(customWeight)) + " lb", for: .normal)
            }
        } else {
            if customWeightKg == true {
                customButtonInventory.setTitle(String(customWeight) + " kg", for: .normal)
            } else {
                customButtonInventory.setTitle(String(customWeight) + " lb", for: .normal)
            }
        }
        if Double(customWeight2).rounded() == Double(customWeight2) {
            if customWeightKg2 == true {
                customButtonInventory2.setTitle(String(Int(customWeight2)) + " kg", for: .normal)
            } else {
                customButtonInventory2.setTitle(String(Int(customWeight2)) + " lb", for: .normal)
            }
        } else {
            if customWeightKg2 == true {
                customButtonInventory2.setTitle(String(customWeight2) + " kg", for: .normal)
            } else {
                customButtonInventory2.setTitle(String(customWeight2) + " lb", for: .normal)
            }
        }
        
        
        
        
        let width = (#imageLiteral(resourceName: "customButton").size.width)
        customButtonInventory.titleEdgeInsets.left = 0 - 1.2 * width
        
//        customButtonInventory2.setTitle(String(customWeight2), for: .normal)
//        let width = (#imageLiteral(resourceName: "customButton").size.width)
        customButtonInventory2.titleEdgeInsets.left = 0 - 1.2 * width
        
        
        if useBothPlates == true {
            useBothLbandKgSwitch.isOn = true
        }
        
        
//        if isThisCollarsSwitchOn == true {
//            collarsSwitch.isOn = true
//        }
        if defaults.bool(forKey: "collars") == true {
            collarsSwitch.isOn = true
        }
        
        if barWeightKg == true {
//            barWeightTextField.placeholder = "Currently " + String(Int((barweightstartingat45 * 0.45359237).rounded())) + "kg"
            BarWeightLabel.text = "Bar Weight (Currently " + String(Int((barweightstartingat45 * 0.45359237).rounded())) + " kg)"
//            BarWeightLabel.text = "Bar Weight (Currently " + oldResetText + " kg)"
        } else {
//            barWeightTextField.placeholder = "Currently " + String(barweightstartingat45) + "lb"
            BarWeightLabel.text = "Bar Weight (Currently " + String(Int(barweightstartingat45)) + " lb)"
        }
//        let screenWidth = UIScreen.mainScreen().bounds.width
//        textInput.frame.size.width = screenWidth
        
        
        inventoryScrollView.contentSize = CGSize(width: 300, height: 2200)
        
        
        bigredinventorylabel.text = String(bigRedInventory)
        bigredstepper.value = Double(bigRedInventory)
        
        bigblueinventorylabel.text = String(bigBlueInventory)
        bigbluestepper.value = Double(bigBlueInventory)
        
        bigyellowinventorylabel.text = String(bigYellowInventory)
        bigyellowstepper.value = Double(bigYellowInventory)
        
        biggreeninventorylabel.text = String(bigGreenInventory)
        biggreenstepper.value = Double(bigGreenInventory)
        
        bigwhiteinventorylabel.text = String(bigWhiteInventory)
        bigwhitestepper.value = Double(bigWhiteInventory)
        
        littleredinventorylabel.text = String(littleRedInventory)
        littleredstepper.value = Double(littleRedInventory)
        
        littleblueinventorylabel.text = String(littleBlueInventory)
        littlebluestepper.value = Double(littleBlueInventory)
        
        littleyellowlabel.text = String(littleYellowInventory)
        littleyellowstepper.value = Double(littleYellowInventory)
        
        littlegreenlabel.text = String(littleGreenInventory)
        littlegreenstepper.value = Double(littleGreenInventory)
        
        littlewhitelabel.text = String(littleWhiteInventory)
        littlewhitestepper.value = Double(littleWhiteInventory)
        
        powerquarterlabel.text = String(powerQuarterInventory)
        powerquarterstepper.value = Double(powerQuarterInventory)
        
        customLabel.text = String(customInventory)
        customStepper.value = Double(customInventory)
        
        customLabel2.text = String(customInventory2)
        customStepper2.value = Double(customInventory2)
        
        fortyfivelabel.text = String(fortyfiveinventory)
        fortyfivestepper.value = Double(fortyfiveinventory)
        
        thirtyfivelabel.text = String(thirtyfiveinventory)
        thirtyfivestepper.value = Double(thirtyfiveinventory)
        
        twentyfivelabel.text = String(twentyfiveinventory)
        twentyfivestepper.value = Double(twentyfiveinventory)

        tenlabel.text = String(teninventory)
        tenstepper.value = Double(teninventory)

        fivelabel.text = String(fiveinventory)
        fivestepper.value = Double(fiveinventory)

        twohalflabel.text = String(twohalfinventory)
        twohalfstepper.value = Double(twohalfinventory)
        
        onepoundlabel.text = String(onepoundinventory)
        onepoundstepper.value = Double(onepoundinventory)
        
        threequarterlabel.text = String(threequartersinventory)
        threequarterstepper.value = Double(threequartersinventory)
        
        halfpoundlabel.text = String(onehalfinventory)
        halfpoundstepper.value = Double(onehalfinventory)
        
        quarterpoundlabel.text = String(onequarterinventory)
        quarterpoundstepper.value = Double(onequarterinventory)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBOutlet weak var collarsSwitch: UISwitch!
    
    
    @IBAction func changethecollars(_ sender: UISwitch) {
        
        
        if collarsSwitch.isOn {
            isThisCollarsSwitchOn = true
            defaults.set(true, forKey: "collars")
            justResetbarWeight = true
        } else {
            isThisCollarsSwitchOn = false
            defaults.set(false, forKey: "collars")
            justResetbarWeight = true
        }
    }
    
    
    @IBOutlet weak var BarWeightLabel: UILabel!
    
    @IBOutlet weak var barWeightTextField: UITextField!
    @IBOutlet weak var barWeightGoButton: UIButton!
    
    @IBOutlet weak var poundWeightGoButton: UIButton!
    
    @IBAction func resetWeight(_ sender: UIButton) { //kg
        
        if let text = barWeightTextField.text, let weight = Double(text) {
            barWeightKg = true
            defaults.set(true, forKey: "barweightkg")
            justResetbarWeight = true
            barweightstartingat45 = Double(text)! / 0.45359237
            defaults.set(Double(text)! / 0.45359237, forKey: "barweight")
            barWeightTextField.resignFirstResponder()
            BarWeightLabel.text = "Bar Weight (Currently " + text + " kg)"
            oldResetText = text
        } else {
            barWeightTextField.text = ""
        }
        
        barWeightTextField.resignFirstResponder()

    }
    
    @IBAction func resetWeightPounds(_ sender: UIButton) { //pounds
       
        
        if let text = barWeightTextField.text, let weight = Double(text) {
            barWeightKg = false
            defaults.set(false, forKey: "barweightkg")
            
            justResetbarWeight = true
            barweightstartingat45 = Double(text)!
            defaults.set(Double(text)!, forKey: "barweight")
            BarWeightLabel.text = "Bar Weight (Currently " + text + " lb)"
        } else {
            barWeightTextField.text = ""
        }
        
        barWeightTextField.resignFirstResponder()
        
    }
    
    
    
    @IBOutlet weak var customTextField: UITextField!
    
    @IBOutlet weak var customTextField2: UITextField!
    
    @IBOutlet weak var customKgButton: UIButton!
    @IBOutlet weak var customlbButton: UIButton!
    
    @IBOutlet weak var customKgButton2: UIButton!
    
    @IBOutlet weak var customlbButton2: UIButton!
    
    @IBAction func customKgTapped(_ sender: UIButton) {
        let text = customTextField.text
        
        if let text = text, Double(text) != nil {
        
            customWeight = Double(text)!
            customWeightKg = true
            defaults.set(true, forKey: "customkg")
            defaults.set(customWeight, forKey: "customWeight")
            
            if Double(text)?.rounded() == Double(text) {
                customButtonInventory.setTitle(String(Int(customWeight)) + " kg", for: .normal)
            } else {
                customButtonInventory.setTitle(String(customWeight) + " kg", for: .normal)
            }
            
            let width = (#imageLiteral(resourceName: "customButton").size.width)
            customButtonInventory.titleEdgeInsets.left = 0 - 1.2 * width
            
        } else {
            customTextField.text = ""
        }
        customTextField.resignFirstResponder()

    }
    
    @IBAction func customLbTapped(_ sender: UIButton) {
        
        let text = customTextField.text
        
        if let text = text, Double(text) != nil {
            
            customWeight = Double(text)!
            customWeightKg = false
            defaults.set(false, forKey: "customkg")
            defaults.set(customWeight, forKey: "customWeight")
            
            //if int input, dont show .0.  ex:  45 == true, 45.5 == false
            if Double(text)?.rounded() == Double(text) {
                //int input 45
                customButtonInventory.setTitle(String(Int(customWeight)) + " lb", for: .normal)
            } else {
                //double input 45.5
                customButtonInventory.setTitle(String(customWeight) + " lb", for: .normal)
            }
            
            let width = (#imageLiteral(resourceName: "customButton").size.width)
            customButtonInventory.titleEdgeInsets.left = 0 - 1.2 * width
            
        } else {
            customTextField.text = ""
        }
        customTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    @IBAction func customKgTapped2(_ sender: UIButton) {
        
        let text = customTextField2.text
        
        if let text = text, Double(text) != nil {
            
            customWeight2 = Double(text)!
            customWeightKg2 = true
            defaults.set(true, forKey: "customkg2")
            //                defaults.set(Double(text)!, forKey: "custom")
            //                customLabelDescribingWeight.text = String(customWeight) + " kg"
            //customTextField2.resignFirstResponder()
            defaults.set(customWeight2, forKey: "customWeight2")
            
            if Double(text)?.rounded() == Double(text) {
                customButtonInventory2.setTitle(String(Int(customWeight2)) + " kg", for: .normal)
            } else {
                customButtonInventory2.setTitle(String(customWeight2) + " kg", for: .normal)
            }
            
            let width = (#imageLiteral(resourceName: "customButton").size.width)
            customButtonInventory2.titleEdgeInsets.left = 0 - 1.2 * width
            
        } else {
            customTextField2.text = ""
        }
        customTextField2.resignFirstResponder()
        
    }
    
    
    @IBAction func customLbTapped2(_ sender: UIButton) {
        let text = customTextField2.text
        
        if let text = text, Double(text) != nil {
            
            customWeight2 = Double(text)!
            customWeightKg2 = false
            defaults.set(false, forKey: "customkg2")
            defaults.set(customWeight2, forKey: "customWeight2")
            
            if Double(text)?.rounded() == Double(text) {
                customButtonInventory2.setTitle(String(Int(customWeight2)) + " lb", for: .normal)
            } else {
                customButtonInventory2.setTitle(String(customWeight2) + " lb", for: .normal)
            }
            
            let width = (#imageLiteral(resourceName: "customButton").size.width)
            customButtonInventory2.titleEdgeInsets.left = 0 - 1.2 * width
            
        } else {
            customTextField2.text = ""
        }
        customTextField2.resignFirstResponder()
        
        
    }
    
    
}
