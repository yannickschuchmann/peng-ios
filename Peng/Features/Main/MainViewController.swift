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
        
        if (user.nick.value == "") {
            self.performSegueWithIdentifier("onEmptyNick", sender: self)
        }
        
        user.nick
            .bindTo(self.nick.bnd_text)
        user.slogan
            .bindTo(self.slogan.bnd_text)
        user.duelsCount
            .map { "\($0)" }
            .bindTo(self.duelsCount.bnd_text)
        user.rank
            .map { "\($0)" }
            .bindTo(self.rank.bnd_text)
        user.friendsCount
            .map { "\($0)" }
            .bindTo(self.friendsCount.bnd_text)
        
        user.characterName.observe { name in
            self.character.image = UIImage(named: "character_" + name)
        }
        
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
