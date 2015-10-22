//
//  SettingsViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 14.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBAction func savedCharacter(segue: UIStoryboardSegue) {}
    @IBAction func skipHowTo(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        self.performSegueWithIdentifier("logOut", sender: self)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        
    }
    
}
