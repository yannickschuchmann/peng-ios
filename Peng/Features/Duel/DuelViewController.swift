//
//  DuelViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 26.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit
import APNGKit

class DuelViewController: UIViewController {
    
    @IBOutlet weak var apngView: APNGImageView!
    
    @IBOutlet var myLifes: UILabel!
    @IBOutlet var opLifes: UILabel!
    
    @IBOutlet var myBullet1: UIImageView!
    @IBOutlet var myBullet2: UIImageView!
    @IBOutlet var myBullet3: UIImageView!
    
    @IBOutlet var opBullet1: UIImageView!
    @IBOutlet var opBullet2: UIImageView!
    @IBOutlet var opBullet3: UIImageView!

    
    @IBOutlet weak var myCharacter: APNGImageView!
    @IBOutlet weak var opCharacter: APNGImageView!
    
    
    var passedDuel: Duel!
    var me: Actor?
    var op: Actor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Spinner.show()
        API.getDuel(passedDuel.id.value, userId: CurrentUser.getUser().id.value) { duel in
            Spinner.hide()
            self.passedDuel = duel
            self.configureView()
        }

    }
    
    func configureView() {
        self.me = self.passedDuel.me.value
        self.op = self.passedDuel.opponent.value

        self.setupBullets(myBullet1, b2: myBullet2, b3: myBullet3, bullets: self.me!.shots.value)
        self.setupBullets(opBullet1, b2: opBullet2, b3: opBullet3, bullets: self.op!.shots.value)
        
        self.myLifes.text = String(self.me!.hitPoints.value)
        self.opLifes.text = String(self.op!.hitPoints.value)
        
        if let image = APNGImage(named: "animated2") {
            image.repeatCount = 0
            
            myCharacter.image = image
            myCharacter.startAnimating()
                        
            opCharacter.image = image
            opCharacter.startAnimating()
            
        }
    }
    
    func setupBullets(b1: UIImageView, b2: UIImageView, b3: UIImageView, bullets: Int) {
        b1.image = UIImage(named: bullets > 0 ? "shoot_loaded" : "shoot_unloaded")
        b2.image = UIImage(named: bullets > 1 ? "shoot_loaded" : "shoot_unloaded")
        b3.image = UIImage(named: bullets > 2 ? "shoot_loaded" : "shoot_unloaded")
    }
}