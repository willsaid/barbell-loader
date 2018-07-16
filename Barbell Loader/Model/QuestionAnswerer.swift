//
//  QuestionAnswerer.swift
//  Barbell Loader
//
//  Created by Will Said on 7/12/18.
//  Copyright © 2018 Will Said. All rights reserved.
//



import UIKit



class MyQuestionAnswerer {
    
    
    // MARK: - CLASS VARIABLES
    
    let question: String
    let kilosToPounds: Bool
    let barWeight: Double
    let collars: Bool
    
    var images = [UIImage]()
    
    
    init(question: String, kilosToPounds: Bool, barWeight: Double, collars: Bool) {
        self.question = question
        self.kilosToPounds = kilosToPounds
        self.barWeight = barWeight
        self.collars = collars
    }
    
    
    
    
    
    
    
    // MARK: - PUBLIC RESPONSE METHOD

    
    func response() -> (String, [UIImage]) {
        
        //note: barWeight is in POUNDS
        
        //to be returned
        
        let tuple = conversions(question: question)
        return finalOutput(input: tuple.0, roundedPoundsInput: tuple.1, poundsToString: tuple.2, kgToString: tuple.3)
        
    }
    
    
    
    
    
    
    
    
    
    // MARK: - HELPER FUNCTIONS
    
    
    
    
    private func conversions(question: String) -> (Double?, Double?, String, String) {
        var poundsToString = ""
        var kgToString = ""
        var finalKgFromPounds = 0.0;
        var finalPoundsFromKg = 0;
        
        
        let input = Double(question)
        
        
        var finalPoundsFromKgNotInt = 0.0
        let i = input
        let inp = i! / conversionDecimal
        let pounds = inp
        if pounds > Double(Int.max) {
            finalPoundsFromKgNotInt = pounds.rounded()
        } else {
            finalPoundsFromKg = Int(pounds.rounded())
        }
        if finalPoundsFromKgNotInt > 1.0 {
            poundsToString = String(finalPoundsFromKgNotInt)
        } else {
            poundsToString = String(finalPoundsFromKg)
        }
        
        //pounds to kg. Goes to 0.5 accuracy.
        var roundedPoundsInput = input?.rounded()
        let roundedtoonedec = (input! * 10).rounded()
        if roundedtoonedec.truncatingRemainder(dividingBy: 10) == 5 {
            roundedPoundsInput = Double(String(format: "%.1f", input!))
        }
        
        let kg = input! * 0.45359237
        let roundedKgToOneDec = (kg * 10).rounded()
        if roundedKgToOneDec.truncatingRemainder(dividingBy: 10) == 5 {
            finalKgFromPounds = roundedKgToOneDec / 10.0
            kgToString = String(format: "%.1f", kg)
        } else {
            finalKgFromPounds = kg.rounded()
            if finalKgFromPounds > Double(Int.max) {
                kgToString = String(finalKgFromPounds)
            } else {
                kgToString = String(Int(finalKgFromPounds))
            }
        }
        
        return (input, roundedPoundsInput, poundsToString, kgToString)
    }
    
    
    func finalOutput(input: Double?, roundedPoundsInput: Double?, poundsToString: String, kgToString: String) -> (String, [UIImage]) {
        if kilosToPounds == true {
            
            if useBothPlates == true {
                _ = usingBothPlates(inputWeight: Double(question)! / conversionDecimal)
            } else {
                _ = KgStringOfPlates(inputKg: input!)
            }
            
            return ("\(question) kg  (\(poundsToString) lb)", images)
            
        } else {
            
            if useBothPlates == true {
                _ = usingBothPlates(inputWeight: Double(question)!)
            } else {
                _ = PoundStringOfPlates(inputPounds: roundedPoundsInput!, dividor: false)
            }
            
            if roundedPoundsInput! < Double(Int.max) && Int((roundedPoundsInput?.rounded())! - 0.5) == Int(roundedPoundsInput!) {
                let returnpoundsinput = String(format: "%.1f", input!)
                return ("\(returnpoundsinput) lb  (\(kgToString) kg)", images)
            } else if roundedPoundsInput! < Double(Int.max) {
                return ("\(Int(roundedPoundsInput!)) lb  (\(kgToString) kg)", images)
            } else {
                return ("\(roundedPoundsInput!) lb  (\(kgToString) kg)", images)
            }
            
        }
    }
    
    
    
    
    
    
    func KgStringOfPlates (inputKg: Double) {
        
        var KgFromPoundsReplica = inputKg - (barWeight * 0.45359237) // - 20 for just plates. bar is 20.
        
        if collars == true {
            KgFromPoundsReplica -= 5
        }
        
        
        
        
        //kilo plates
        //if input is pounds, and output is amount of kg and amount of kg plates:
        var redPlates = bigRedInventory
        var bluePlates = bigBlueInventory
        var yellowPlates = bigYellowInventory
        var greenPlates = bigGreenInventory
        var whitePlates = bigWhiteInventory
        var littleRedPlates = littleRedInventory
        var littleBluePlates = littleBlueInventory
        var littleYellowPlates = littleYellowInventory
        var littleGreenPlates = littleGreenInventory
        var littleWhitePlates = littleWhiteInventory
        var powerliftingoneandhalf = powerQuarterInventory
        
        var customPlates = customInventory
        var customPlates2 = customInventory2
        
        
        
        while  KgFromPoundsReplica > 0 {
            
            if customWeight > 25 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 25 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 50 >= 0 && redPlates >= 2 {
                redPlates -= 2
                images.append(#imageLiteral(resourceName: "bigRed"))
                KgFromPoundsReplica -= 50
                //                    returnChange -= 50
                continue
            } else if customWeight > 20 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 20 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 40 >= 0 && bluePlates >= 2 {
                bluePlates -= 2
                images.append(#imageLiteral(resourceName: "bigBlue"))
                KgFromPoundsReplica -= 40
                //                    returnChange -= 40
                continue
            } else if customWeight > 15 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 15 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 30 >= 0 && yellowPlates >= 2 {
                yellowPlates -= 2
                images.append(#imageLiteral(resourceName: "bigYellow"))
                KgFromPoundsReplica -= 30
                //                    returnChange -= 30
                continue
            } else if customWeight > 10 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 10 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 20 >= 0 && greenPlates >= 2 {
                greenPlates -= 2
                images.append(#imageLiteral(resourceName: "bigGreen"))
                KgFromPoundsReplica -= 20
                //                    returnChange -= 20
                continue
            } else if customWeight > 5 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 5 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 10 >= 0 && whitePlates >= 2 {
                whitePlates -= 2
                images.append(#imageLiteral(resourceName: "white"))
                KgFromPoundsReplica -= 10
                //                    returnChange -= 10
                continue
            } else if customWeight > 2.5 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 2.5 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 5 >= 0 && littleRedPlates >= 2 {
                littleRedPlates -= 2
                images.append(#imageLiteral(resourceName: "littleRed"))
                KgFromPoundsReplica -= 5
                //                    returnChange -= 5
                continue
            } else if customWeight > 2 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 2 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 4 >= 0 && littleBluePlates >= 2 {
                littleBluePlates -= 2
                images.append(#imageLiteral(resourceName: "littleBlue"))
                KgFromPoundsReplica -= 4
                continue
                //                    returnChange -= 4
            } else if customWeight > 1.5 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 1.5 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 3 >= 0 && littleYellowPlates >= 2 {
                littleYellowPlates -= 2
                images.append(#imageLiteral(resourceName: "littleYellow"))
                KgFromPoundsReplica -= 3
                continue
            } else if customWeight > 1 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 1 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 2 >= 0 && littleGreenPlates >= 2 {
                littleGreenPlates -= 2
                images.append(#imageLiteral(resourceName: "littleGreen"))
                KgFromPoundsReplica -= 2
                continue
            } else if customWeight > 0.5 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 0.5 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 1 >= 0 && littleWhitePlates >= 2 {
                littleWhitePlates -= 2
                images.append(#imageLiteral(resourceName: "littleWhite"))
                KgFromPoundsReplica -= 1
                continue
            } else if customWeight > 0.25 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 > 0.25 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else if KgFromPoundsReplica - 0.5 >= 0 && powerliftingoneandhalf >= 2 {
                powerliftingoneandhalf -= 2
                images.append(#imageLiteral(resourceName: "powerquarterkilo"))
                KgFromPoundsReplica -= 0.5
                continue
            } else if customWeight < 0.25 && customWeightKg == true && KgFromPoundsReplica - customWeight * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                KgFromPoundsReplica -= customWeight * 2.0
                continue
            } else if customWeight2 < 0.25 && customWeightKg2 == true && KgFromPoundsReplica - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                KgFromPoundsReplica -= customWeight2 * 2.0
                continue
            } else {
                returnChange = KgFromPoundsReplica;
                KgFromPoundsReplica = 0
            }
        }
        
        if collars {
            images.append(#imageLiteral(resourceName: "weighted2.5kgcollar"))
        }
        
    }
    
    
    
    
    
    
    func PoundStringOfPlates(inputPounds: Double, dividor: Bool) {
        
        var poundsPlates = inputPounds - barWeight
        
        if collars {
            poundsPlates -= 11
        }
        
        returnChangelb = 0
        
        //pound plates
        var fortyfives = fortyfiveinventory
        var thirtyfives = thirtyfiveinventory
        var twentyfives = twentyfiveinventory
        var tens = teninventory
        var fives = fiveinventory
        var twohalves = twohalfinventory
        var onepound = onepoundinventory
        var threequarter = threequartersinventory
        var onehalf = onehalfinventory
        var onequarter = onequarterinventory
        
        var customPlates = customInventory
        var customPlates2 = customInventory2
        
        var counter = 0
        while  poundsPlates > 0 {
            if customWeight > 45 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 45 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 90 >= 0 && fortyfives >= 2 {
                fortyfives -= 2
                images.append(#imageLiteral(resourceName: "fortyfive"))
                poundsPlates -= 90
            } else if customWeight > 35 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 35 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 70 >= 0 && thirtyfives >= 2 {
                thirtyfives -= 2
                images.append(#imageLiteral(resourceName: "thirtyfiveplate"))
                poundsPlates -= 70
                
            } else if customWeight > 25 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 25 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 50 >= 0 && twentyfives >= 2 {
                twentyfives -= 2
                images.append(#imageLiteral(resourceName: "twentyfive"))
                poundsPlates -= 50
            } else if customWeight > 10 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 10 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            }  else if poundsPlates - 20 >= 0 && tens >= 2 {
                tens -= 2
                images.append(#imageLiteral(resourceName: "ten"))
                poundsPlates -= 20
                
            } else if customWeight > 5 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 5 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 10 >= 0 && fives >= 2 {
                fives -= 2
                images.append(#imageLiteral(resourceName: "five"))
                poundsPlates -= 10
                
            } else if customWeight > 2.5 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 2.5 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 5 >= 0 && twohalves >= 2 {
                twohalves -= 2
                images.append(#imageLiteral(resourceName: "twohalf"))
                poundsPlates -= 5
                
            } else if customWeight > 1 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 1 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 2 >= 0 && onepound >= 2 {
                onepound -= 2
                images.append(#imageLiteral(resourceName: "onepoundplates"))
                poundsPlates -= 2
                
            } else if customWeight > 0.75 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 0.75 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 1.5 >= 0 && threequarter >= 2 {
                threequarter -= 2
                images.append(#imageLiteral(resourceName: "threequarterplate"))
                poundsPlates -= 1.5
                
            } else if customWeight > 0.5 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 0.5 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 1 >= 0 && onehalf >= 2 {
                onehalf -= 2
                images.append(#imageLiteral(resourceName: "halfpoundplate"))
                poundsPlates -= 1
                if counter == 0 {
                }
            } else if customWeight > 0.25 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 > 0.25 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else if poundsPlates - 0.5 >= 0 && onequarter >= 2 {
                onequarter -= 2
                images.append(#imageLiteral(resourceName: "quarterpoundplate"))
                poundsPlates -= 0.5
                if counter == 0 {
                }
            } else if customWeight < 0.25 && customWeightKg == false && poundsPlates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                poundsPlates -= customWeight * 2.0
            } else if customWeight2 < 0.25 && customWeightKg2 == false && poundsPlates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                poundsPlates -= customWeight2 * 2.0
            } else {
                returnChangelb = poundsPlates
                poundsPlates = 0
            }
            counter += 1
        }
        if collars == true {
            images.append(#imageLiteral(resourceName: "weighted2.5kgcollar"))
        }
        
        
        
    }
    
    
    
    
    
    func usingBothPlates(inputWeight: Double) {
        
        //inputWeight is in pounds.
        //calculations done in pounds
        //return pounds and then kg
        
        var plates = inputWeight - barWeight
        
        if collars == true {
            plates -= 11
        }
        
        
        returnChangelb = 0
        
        
        var redPlates = bigRedInventory
        var bluePlates = bigBlueInventory
        var yellowPlates = bigYellowInventory
        var greenPlates = bigGreenInventory
        var whitePlates = bigWhiteInventory
        var littleRedPlates = littleRedInventory
        var littleBluePlates = littleBlueInventory
        var littleYellowPlates = littleYellowInventory
        var littleGreenPlates = littleGreenInventory
        var littleWhitePlates = littleWhiteInventory
        var powerliftingoneandhalf = powerQuarterInventory
        
        var customPlates = customInventory
        var customPlates2 = customInventory2
        
        //pound plates
        var fortyfives = fortyfiveinventory
        var thirtyfives = thirtyfiveinventory
        var twentyfives = twentyfiveinventory
        var tens = teninventory
        var fives = fiveinventory
        var twohalves = twohalfinventory
        var onepound = onepoundinventory
        var threequarter = threequartersinventory
        var onehalf = onehalfinventory
        var onequarter = onequarterinventory
        
        
        while  plates > 0 {
            if customWeight > 25 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 25 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if customWeight > 45 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 45 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 50 / conversionDecimal >= 0 && redPlates >= 2 {
                redPlates -= 2
                images.append(#imageLiteral(resourceName: "bigRed"))
                plates -= 50 / conversionDecimal
                //                    returnChange -= 50
                continue
            } else if plates - 90 >= 0 && fortyfives >= 2 {
                fortyfives -= 2
                images.append(#imageLiteral(resourceName: "fortyfive"))
                plates -= 90
                continue
            } else if customWeight > 20 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 20 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 40 / conversionDecimal >= 0 && bluePlates >= 2 {
                bluePlates -= 2
                images.append(#imageLiteral(resourceName: "bigBlue"))
                plates -= 40 / conversionDecimal
                //                    returnChange -= 40
                continue
            } else if customWeight > 35 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 35 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 70 >= 0 && thirtyfives >= 2 {
                thirtyfives -= 2
                images.append(#imageLiteral(resourceName: "thirtyfiveplate"))
                plates -= 70
                continue
            } else if customWeight > 15 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 15 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 30 / conversionDecimal >= 0 && yellowPlates >= 2 {
                yellowPlates -= 2
                images.append(#imageLiteral(resourceName: "bigYellow"))
                plates -= 30 / conversionDecimal
                //                    returnChange -= 30
                continue
            } else if customWeight > 25 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 25 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 50 >= 0 && twentyfives >= 2 {
                twentyfives -= 2
                images.append(#imageLiteral(resourceName: "twentyfive"))
                plates -= 50
                continue
            } else if customWeight > 10 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "customPlate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 10 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "customPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 20 / conversionDecimal >= 0 && greenPlates >= 2 {
                greenPlates -= 2
                images.append(#imageLiteral(resourceName: "bigGreen"))
                plates -= 20 / conversionDecimal
                //                    returnChange -= 20
                continue
            } else if customWeight > 5 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 5 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 10 / conversionDecimal >= 0 && whitePlates >= 2 {
                whitePlates -= 2
                images.append(#imageLiteral(resourceName: "white"))
                plates -= 10 / conversionDecimal
                //                    returnChange -= 10
                continue
            } else if customWeight > 10 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 10 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            }  else if plates - 20 >= 0 && tens >= 2 {
                tens -= 2
                images.append(#imageLiteral(resourceName: "ten"))
                plates -= 20
                continue
            } else if customWeight > 2.5 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 2.5 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 5 / conversionDecimal >= 0 && littleRedPlates >= 2 {
                littleRedPlates -= 2
                images.append(#imageLiteral(resourceName: "littleRed"))
                plates -= 5 / conversionDecimal
                //                    returnChange -= 5
                continue
            } else if customWeight > 5 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 5 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 10 >= 0 && fives >= 2 {
                fives -= 2
                images.append(#imageLiteral(resourceName: "five"))
                plates -= 10
                continue
            } else if customWeight > 2 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 2 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 4 / conversionDecimal >= 0 && littleBluePlates >= 2 {
                littleBluePlates -= 2
                images.append(#imageLiteral(resourceName: "littleBlue"))
                plates -= 4 / conversionDecimal
                //                    returnChange -= 4
                continue
            } else if customWeight > 1.5 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 1.5 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 3 / conversionDecimal >= 0 && littleYellowPlates >= 2 {
                littleYellowPlates -= 2
                images.append(#imageLiteral(resourceName: "littleYellow"))
                //                    returnChange -= 3
                plates -= 3 / conversionDecimal
                continue
            } else if customWeight > 2.5 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 2.5 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 5 >= 0 && twohalves >= 2 {
                twohalves -= 2
                images.append(#imageLiteral(resourceName: "twohalf"))
                plates -= 5
                continue
            } else if customWeight > 1 && customWeightKg == true && plates - customWeight * 2 / conversionDecimal >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 1 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 2 / conversionDecimal >= 0 && littleGreenPlates >= 2 {
                littleGreenPlates -= 2
                images.append(#imageLiteral(resourceName: "littleGreen"))
                plates -= 2 / conversionDecimal
                //                    returnChange -= 2
                continue
            } else if customWeight > 0.5 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 0.5 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 1 / conversionDecimal >= 0 && littleWhitePlates >= 2 {
                littleWhitePlates -= 2
                images.append(#imageLiteral(resourceName: "littleWhite"))
                plates -= 1 / conversionDecimal
                //                    returnChange -= 1
                continue
            } else if customWeight > 1 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 1 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 2 >= 0 && onepound >= 2 {
                onepound -= 2
                images.append(#imageLiteral(resourceName: "onepoundplates"))
                plates -= 2
                continue
            } else if customWeight > 0.75 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 0.75 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 1.5 >= 0 && threequarter >= 2 {
                threequarter -= 2
                images.append(#imageLiteral(resourceName: "threequarterplate"))
                plates -= 1.5
                continue
            } else if customWeight > 0.25 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 > 0.25 && customWeightKg2 == true && plates - customWeight2 * 2 >= 0 && customPlates2 >= 2 && customWeight2 / conversionDecimal > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if plates - 0.5 / conversionDecimal >= 0 && powerliftingoneandhalf >= 2 {
                powerliftingoneandhalf -= 2
                images.append(#imageLiteral(resourceName: "powerquarterkilo"))
                plates -= 0.5 / conversionDecimal
                //                    returnChange -= 0.5;
                continue
            } else if customWeight > 0.5 && customWeightKg == false
                && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 0.5 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 1 >= 0 && onehalf >= 2 {
                onehalf -= 2
                images.append(#imageLiteral(resourceName: "halfpoundplate"))
                plates -= 1
                continue
            } else if customWeight > 0.25 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 > 0.25 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else if plates - 0.5 >= 0 && onequarter >= 2 {
                onequarter -= 2
                images.append(#imageLiteral(resourceName: "quarterpoundplate"))
                plates -= 0.5
                continue
            } else if customWeight < 0.25 && customWeightKg == true && plates - customWeight / conversionDecimal * 2 >= 0 && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight / conversionDecimal * 2.0
                continue
            } else if customWeight2 < 0.25 && customWeightKg2 == true && plates - customWeight2 / conversionDecimal * 2 >= 0 && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 / conversionDecimal * 2.0
                continue
            } else if customWeight < 0.25 && customWeightKg == false && plates - customWeight * 2 >= 0
                && customPlates >= 2 && customWeight > 0 {
                customPlates -= 2
                images.append(#imageLiteral(resourceName: "littlecustomplate"))
                plates -= customWeight * 2.0
                continue
            } else if customWeight2 < 0.25 && customWeightKg2 == false && plates - customWeight2 * 2 >= 0
                && customPlates2 >= 2 && customWeight2 > 0 {
                customPlates2 -= 2
                images.append(#imageLiteral(resourceName: "littleCustomPlate-1"))
                plates -= customWeight2 * 2.0
                continue
            } else {
                returnChangelb = plates
                returnChange = plates * conversionDecimal
                plates = 0
            }
            
        }
        
        
        if collars {
            images.append(#imageLiteral(resourceName: "weighted2.5kgcollar"))
        }
        
    }
    
    
}












