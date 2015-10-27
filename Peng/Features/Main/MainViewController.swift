//
//  MainViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 07.07.15.
//  Copyright (c) 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var duelsCount: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    
    
    @IBOutlet var openDuelsTableView: UITableView!
    
    @IBOutlet weak var openDuelsTableViewHeight: NSLayoutConstraint!
    var user : User!
    
    var initial: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.user = CurrentUser.getUser()
        
        if (self.user.nick.value == "") {
            self.performSegueWithIdentifier("onEmptyNick", sender: self)
        }
        
        self.openDuelsTableView.rowHeight = 100
        
        self.openDuelsTableView.delegate = self
        self.openDuelsTableView.dataSource = self
        
        self.configureView()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if (self.initial) {
            self.initial = false
            return
        }
        
        print("refresh")
        API.getUser(self.user.id.value) { user in
            print("update there")
            CurrentUser.setUser(user)
            self.user = user
            self.openDuelsTableView.reloadData()
            self.configureView()

            print("updated")
        }
    }
    
    func configureView() {
        
        self.user.nick
            .bindTo(self.nick.bnd_text)
        self.user.slogan
            .bindTo(self.slogan.bnd_text)
        self.user.duelsCount
            .map { "\($0)" }
            .bindTo(self.duelsCount.bnd_text)
        self.user.rank
            .map { "\($0)" }
            .bindTo(self.rank.bnd_text)
        self.user.friendsCount
            .map { "\($0)" }
            .bindTo(self.friendsCount.bnd_text)
        
        self.user.characterName.observe { name in
            self.character.image = UIImage(named: "character_" + name)
        }
        
        
        self.openDuelsTableViewHeight.constant = 0;
        
        // force a table to redraw
        self.openDuelsTableView.setNeedsLayout()
        self.openDuelsTableView.layoutIfNeeded()
        
        // now table has real height
        self.openDuelsTableViewHeight.constant = self.openDuelsTableView.contentSize.height;

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user.openDuels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("duelCell", forIndexPath: indexPath) as! DuelItemViewCell
        
        let duel : Duel = self.user.openDuels[indexPath.row]
        let opponent : Actor = duel.opponent.value
        
        cell.nick.text = opponent.nick.value
        cell.status.text = duel.status.value
        cell.bet.text = duel.bet.value
        cell.characterImage.image = UIImage(named: "character_" + opponent.characterName.value)
        return cell
    }

}
