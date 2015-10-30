//
//  SensorViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 29.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import AudioToolbox

class SensorViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UIImageView!
    
    private var motionManager: CMMotionManager!
    private var device: UIDevice!
    private var resultCode: Int!
    private var timer : NSTimer?
    private var countdownSteps : Int = 3
    private let minRange = -0.8
    private let maxRange = -5.6

    override func viewDidLoad() {
        motionManager = CMMotionManager()
        
        self.updateCountdown()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)

    }
    
    func updateCountdown() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        if (countdownSteps > 0) {
            countdownLabel.image = UIImage(named: "o_" + String(countdownSteps--))
        } else if (countdownSteps == 0) {
            if motionManager.deviceMotionAvailable {
                self.startSensors()
            }
            countdownLabel.image = UIImage(named: "o_los")
            self.timer!.invalidate()
        }
        
    }
    
    func startSensors() {
        self.checkProximity()
        self.checkMotion()
    }
    
    func stopSensors() {
        self.motionManager.stopDeviceMotionUpdates()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIDeviceProximityStateDidChangeNotification", object: self.device)
        
    }
    
    func checkProximity() {
        device = UIDevice.currentDevice()
        device.proximityMonitoringEnabled = true
        if device.proximityMonitoringEnabled {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "proximityChanged:", name: "UIDeviceProximityStateDidChangeNotification", object: device)
        }
    }
    
    func proximityChanged(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            if (device.proximityState) {
                self.stopSensors()
                self.resultCode = 0 // defensive
                self.performSegueWithIdentifier("backToDuel", sender: self)
            }
        }
    }
    
    func checkMotion() {
        motionManager.deviceMotionUpdateInterval = 0.05
        
        var rotationSum : Double = 0
        var count : Int = 0
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
            deviceManager, error in
            
            let rotation = Double(atan2(deviceManager!.gravity.x, deviceManager!.gravity.y) - M_PI)
            if (rotation > self.maxRange && rotation < self.minRange) {
                count++
                rotationSum += rotation
            } else {
                count = 0
            }
            if count == 5 {
                self.stopSensors()
                self.evaluateMotion(rotationSum, count: count)
            }
        }
    }
    
    func evaluateMotion(rotationSum : Double, count : Int) {
        let fixValue = (rotationSum / Double(count))
        if (fixValue > self.maxRange && fixValue < -3) {
            self.resultCode = 1
        } else if (fixValue < self.minRange && fixValue > -3) {
            self.resultCode = 2
        }
        self.performSegueWithIdentifier("backToDuel", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToDuel" {
            let duelViewController = segue.destinationViewController as! DuelViewController
            duelViewController.passedResultCode = self.resultCode
        }
    }

}