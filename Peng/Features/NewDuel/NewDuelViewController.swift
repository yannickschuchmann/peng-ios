//
//  NewDuelViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 26.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

class NewDuelViewController: UIViewController {
    
    var randomDuel: Duel?
    
    @IBAction func onRandomDuel(sender: AnyObject) {
        Spinner.show()
        API.postRandomDuel(CurrentUser.getUser().id.value) { duel in
            self.randomDuel = duel
            Spinner.hide()
            self.performSegueWithIdentifier("newRandomDuel", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newRandomDuel" && self.randomDuel != nil {
            let duelViewController = segue.destinationViewController as! DuelViewController
            duelViewController.passedDuel = self.randomDuel
        }
    }
}