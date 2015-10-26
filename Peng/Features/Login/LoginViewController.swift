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
import Alamofire

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBAction func logOut(segue:UIStoryboardSegue) {}
    
    let permissions: [String] = ["public_profile", "email", "user_friends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("not logged in")
        } else {
            print("logged in")
            self.loginWithFacebookCredentials()
        }
        
        self.loginButton.readPermissions = self.permissions
        
        self.loginButton.delegate = self
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            self.loginWithFacebookCredentials()
        } else {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User has logged out..")
    }
    
    func loginWithFacebookCredentials() {
        Spinner.show()
        API.loginFacebook(FBSDKAccessToken.currentAccessToken().userID, token: FBSDKAccessToken.currentAccessToken().tokenString) { (responseObject: User?) in
                CurrentUser.setUser(responseObject!)
                self.performSegueWithIdentifier("logIn", sender: self)
                Spinner.hide()
                return
            }
        
    }
    
}

