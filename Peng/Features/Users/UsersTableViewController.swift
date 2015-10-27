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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UsersTableViewCell
        let entry = users[indexPath.row]
        
        cell.nick.text = entry.nick.value
        cell.rank.text = String(entry.rank.value)
        cell.slogan.text = entry.slogan.value
        cell.characterImage.image = UIImage(named: "character_" + entry.characterName.value)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (isNewDuelListing) {
            Spinner.show()
            API.postDuel(CurrentUser.getUser().id.value, opponentId: users[indexPath.row].id.value) { duel in
                self.createdDuel = duel
                Spinner.hide()
                self.performSegueWithIdentifier("newDuel", sender: self)
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