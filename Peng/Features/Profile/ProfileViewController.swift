//
//  DetailViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 07.07.15.
//  Copyright (c) 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var editProfile: UIButton!

    @IBAction func onEditProfile(sender: UIButton) {
        
        self.showEditProfileAlert()
        
    }
    
    var user : User!
    var nickTextField: UITextField!
    var sloganTextField: UITextField!
    var saveButton: UIAlertAction!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
            
        if (isProfileFilled()) {
            self.showEditProfileAlert()
        }
            
        self.nick.text = user.nick
        self.slogan.text = user.slogan
    }
    
    func isProfileFilled() -> Bool {
        return self.user.nick == "" || self.user.slogan == ""
    }
    
    func removeTextFieldObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.nickTextField)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.sloganTextField)
    }
    
    func showEditProfileAlert() {

        
        //set up the alertcontroller
        let title = "Edit profile"
        let message = ""
        
        self.saveButton = UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
            print("Ok Button Pressed")
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
            self.nickTextField?.text? = self.user.nick!
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: textField)
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.sloganTextField = textField
            self.sloganTextField?.placeholder = "Slogan"
            self.sloganTextField?.text? = self.user.slogan!
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: textField)
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    func textFieldTextChanged(sender: AnyObject) {
        self.saveButton.enabled = self.nickTextField!.text!.characters.count >= 1 &&
            self.sloganTextField!.text!.characters.count >= 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.user = CurrentUser.getUser()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

