//
//  ViewController.swift
//  Phidget_Project
//
//  Created by Kyla Vidallo on 2018-10-30.
//  Copyright © 2018 Kyla Vidallo. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    
    let ledArray = [DigitalOutput(), DigitalOutput()]
    let buttonArray = [DigitalInput(), DigitalInput()]
    var redButtonPressed : String = ""
    var rCount : Int = 0
    var gCount : Int = 0
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var redButtonCount: UILabel!
    @IBOutlet weak var greenButtonCount: UILabel!
    
    func attach_handler(sender: Phidget) {
        do{

            let hubPort = try sender.getHubPort()

            if (hubPort == 0){
                print("Button 0 Attached")
            }
            else if (hubPort == 1){
                print("Button 1 Attached")
            }
            else if (hubPort == 2) {
                print("LED 2 Attached")
            }
            else {
                print("LED 3 Attached")
            }

        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    func state_change0 (sender: DigitalInput, state: Bool) {
        do{
            if (state == true){
                print("Button 0 Pressed")
                try ledArray[0].setState(true)
                redButton()
                redCount()
                rCount = rCount + 1
            }
            else {
                print("Button 0 Not Pressed")
                try ledArray[1].setState(false)
            }
        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    func state_change1 (sender: DigitalInput, state: Bool) {
        do{

            if (state == true){
                print("Button 1 Pressed")
                try ledArray[1].setState(true)
                greenButton()
                greenCount()
                gCount = gCount + 1
            }
            else {
                print("Button 1 Not Pressed")
                try ledArray[0].setState(false)
            }
        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    func redButton() {
        DispatchQueue.main.async {
            self.labelOne.text = "Red Button Pressed"
        }
    }

    func redCount() {
        DispatchQueue.main.async {
            self.redButtonCount.text = "Red Button Pressed \(self.rCount)"
        }
    }

    func greenCount() {
        DispatchQueue.main.async {
            self.greenButtonCount.text = "Green Button Pressed \(self.gCount)"
        }
    }

    func greenButton() {
        DispatchQueue.main.async {
            self.labelOne.text = "Green Button Pressed"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            
            try Net.enableServerDiscovery( serverType: .deviceRemote)
            
            for i in 0..<buttonArray.count{
                try buttonArray[i].setDeviceSerialNumber(528057)
                try buttonArray[i].setHubPort(i)
                try buttonArray[i].setIsHubPortDevice(true)
                let _ = buttonArray[i].attach.addHandler(attach_handler)
                try buttonArray[i].open()
            }

            for i in 0..<ledArray.count{
                try ledArray[i].setDeviceSerialNumber(528057)
                try ledArray[i].setHubPort(i + 2)
                try ledArray[i].setIsHubPortDevice(true)
                let _ = ledArray[i].attach.addHandler(attach_handler)
                try ledArray[i].open()
            }
            
            let _ = buttonArray[0].stateChange.addHandler(state_change0)
            let _ = buttonArray[1].stateChange.addHandler(state_change1)
            
        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

