/*
 Copyright © 2017 Apple Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        howManyTimesOpenedApp += 1
        defaults.set(howManyTimesOpenedApp, forKey: "timesOpened")
        print("howManyTimesOpenedApp : " + String(howManyTimesOpenedApp))
        
        if barweightstartingat45 == 0 {
            barweightstartingat45 = 45.0
        }
        
        
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
        defaults.register(defaults: ["barweight" : 45.0])
        defaults.register(defaults: ["weightsLogged" : "Edit me!\n"])
        
        defaults.register(defaults: ["timesOpened" : 0])
    
        
        return true
    }
    
    
    

}

