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
}