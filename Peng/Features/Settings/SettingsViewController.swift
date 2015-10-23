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
    
    @IBAction func checkForUpdates(sender: UIButton) {
        
        
        API.getAppManifest() { response in
            let items = response["items"] as! NSArray
            let versionCode = (items[0]["metadata"] as! NSDictionary)["bundle-version"] as? String
            let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
            
            if (version! != versionCode!) {
                let alertController = UIAlertController(title: "New version", message: "We recommend updating to new version.", preferredStyle: .ActionSheet)

                let updateAction = UIAlertAction(title: "Update", style: .Default) {(alert: UIAlertAction!) in
                    if let url = NSURL(string: API.updatePath) {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alertController.addAction(updateAction)
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Up-to-date", message: "You already got the newest version.", preferredStyle: .ActionSheet)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
        
        
    }
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
