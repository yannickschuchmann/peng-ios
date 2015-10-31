//
//  UsersTableViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 23.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

class UsersTableViewController: UITableViewController {
    var users : [User] = []
    
    var isNewDuelListing: Bool = false
    var createdDuel: Duel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        
        Spinner.show()
        API.getUsers() { response in
            self.users = response
            self.tableView.reloadData()

            Spinner.hide()
        }
        
    }
    
    func showBetAlert(opponentId: Int) {
        
        let title = "What's the bet?"
        
        var betTextField: UITextField = UITextField()
        
        let saveButton = UIAlertAction(title: "Challenge", style: .Default, handler: { (action) -> Void in
            Spinner.show()
            API.postDuel(CurrentUser.getUser().id.value, opponentId: self.users[opponentId].id.value, bet: betTextField.text!) { duel in
                self.createdDuel = duel
                Spinner.hide()
                self.performSegueWithIdentifier("newDuel", sender: self)
            }
            
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alertController.addAction(saveButton)
        alertController.addAction(cancelButton)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            betTextField = textField
            betTextField.placeholder = "e.g. Who buys the next round?"
            
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showUnallowedAlert() {
        
        let title = "You can't challenge yourself!"
        
        let okButton = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        
        alertController.addAction(okButton)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UsersTableViewCell
        let entry = users[indexPath.row]
        
        cell.nick.text = (entry.nick.value == "") ? "New Player" : entry.nick.value
        cell.rank.text = String(entry.rank.value) + ". PLACE"
        cell.slogan.text = entry.slogan.value
        cell.characterImage.image = UIImage(named: "character_" + entry.characterName.value)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (isNewDuelListing) {
            if (users[indexPath.row].id.value == CurrentUser.getUser().id.value) {
                self.showUnallowedAlert()
            } else {
                self.showBetAlert(indexPath.row)
            }
        } else {
            self.performSegueWithIdentifier("showProfile", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if segue.identifier == "showProfile" {
                let profileViewController = segue.destinationViewController as! ProfileViewController
                profileViewController.passedUser = users[indexPath.row]
            } else if segue.identifier == "newDuel" {
                let duelViewController = segue.destinationViewController as! DuelViewController
                duelViewController.passedDuel = self.createdDuel
            }
        }
    }
}