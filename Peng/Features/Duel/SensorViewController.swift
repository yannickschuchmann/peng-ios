//
//  SensorViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 29.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

class SensorViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UIImageView!
    
    override func viewDidLoad() {
        self.updateCountdown()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
    }
    
    var timer : NSTimer?
    var countdownSteps : Int = 3
    func updateCountdown() {
        if (countdownSteps > 0) {
            countdownLabel.image = UIImage(named: "o_" + String(countdownSteps--))
        } else if (countdownSteps == 0) {
            countdownLabel.image = UIImage(named: "o_los")
            self.timer!.invalidate()
            // TODO: add sensor stuff here
        }
        
    }
    
    
}