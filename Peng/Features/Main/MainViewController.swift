//
//  MainViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 07.07.15.
//  Copyright (c) 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var duelsCount: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let user : User = CurrentUser.getUser()
        
        if (user.nick == "") {
            self.performSegueWithIdentifier("onEmptyNick", sender: self)
        }
        
        self.nick.text = user.nick
        self.slogan.text = user.slogan
        self.duelsCount.text = String(user.duelsCount!)
        self.rank.text = String(user.rank!)
        self.friendsCount.text = String(user.friendsCount!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
