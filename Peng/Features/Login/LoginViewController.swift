//
//  LoginViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 14.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("not logged in")
        } else {
            print("logged in")
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
        
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        self.loginButton.delegate = self
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            print("Login complete")
            self.performSegueWithIdentifier("loggedIn", sender: self)
        } else {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User has logged out..")
    }
    
}

