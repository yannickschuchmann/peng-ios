//
//  DetailViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 07.07.15.
//  Copyright (c) 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var editProfileHeight: NSLayoutConstraint!

    @IBOutlet var lastDuelsTableView: UITableView!
    
    @IBOutlet var lastDuelsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var challengeButton: UIButton!

    @IBOutlet weak var challengeButtonHeight: NSLayoutConstraint!

    @IBAction func onEditProfile(sender: UIButton) {
        
        self.showEditProfileAlert()
        
    }
    
    var isCurrentUser : Bool?
    var passedUser : User?
    var user : User!
    var nickTextField: UITextField!
    var sloganTextField: UITextField!
    var saveButton: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.passedUser == nil) {
            self.user = CurrentUser.getUser()
            self.isCurrentUser = true
        } else {
            self.user = self.passedUser
            self.isCurrentUser = false
        }
        
        self.configureView()
    }

    func configureView() {
        
        if (self.isCurrentUser!) {
            if (isProfileFilled()) {
                self.showEditProfileAlert()
            }
            challengeButtonHeight.constant = 0
            challengeButton.hidden = true
        } else {
            editProfileHeight.constant = 10
            editProfile.hidden = true
        }
        
        user.nick
            .bindTo(self.nick.bnd_text)
        user.slogan
            .bindTo(self.slogan.bnd_text)
        user.characterName.observe { name in
            self.character.image = UIImage(named: "character_" + name)
        }
        
        self.lastDuelsTableView.rowHeight = 100
        
        self.lastDuelsTableView.dataSource = self
        self.lastDuelsTableView.delegate = self
        
        self.lastDuelsTableViewHeight.constant = 0
        
        // force a table to redraw
        self.lastDuelsTableView.setNeedsLayout()
        self.lastDuelsTableView.layoutIfNeeded()
        
        // now table has real height
        self.lastDuelsTableViewHeight.constant = self.lastDuelsTableView.contentSize.height;
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user.lastDuels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("duelCell", forIndexPath: indexPath) as! DuelItemViewCell
        
        let duel : Duel = self.user.lastDuels[indexPath.row]
        let opponent : Actor = duel.opponent.value
        
        cell.nick.text = opponent.nick.value
        cell.status.text = duel.status.value
        cell.bet.text = duel.bet.value
        cell.characterImage.image = UIImage(named: "character_" + opponent.characterName.value)
        return cell
    }
    
    func isProfileFilled() -> Bool {
        return self.user.nick.value == "" || self.user.slogan.value == ""
    }
    
    func removeTextFieldObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.nickTextField)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.sloganTextField)
    }
    
    func showEditProfileAlert() {

        let title = "Edit profile"
        let message = ""
        
        self.saveButton = UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
            self.user.nick.value = self.nickTextField.text!
            self.user.slogan.value = self.sloganTextField.text!
            
            CurrentUser.setUser(self.user)

            API.updateUser(self.user) { (user: User) in
            }
            self.removeTextFieldObserver()
        })
        
        if (isProfileFilled()) {
            saveButton.enabled = false
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(saveButton)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.nickTextField = textField
            self.nickTextField?.placeholder = "Nick"
            self.nickTextField?.text? = self.user.nick.value
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: textField)
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.sloganTextField = textField
            self.sloganTextField?.placeholder = "Slogan"
            self.sloganTextField?.text? = self.user.slogan.value
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: textField)
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldTextChanged(sender: AnyObject) {
        self.saveButton.enabled = self.nickTextField!.text!.characters.count >= 1 &&
            self.sloganTextField!.text!.characters.count >= 1
    }

}

