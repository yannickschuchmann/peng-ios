//
//  DuelViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 26.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit
import APNGKit

class DuelViewController: UIViewController {
    @IBOutlet var myLifes: UILabel!
    @IBOutlet var opLifes: UILabel!
    @IBOutlet weak var status: UIImageView!
    
    @IBOutlet var myBullet1: UIImageView!
    @IBOutlet var myBullet2: UIImageView!
    @IBOutlet var myBullet3: UIImageView!
    
    @IBOutlet var opBullet1: UIImageView!
    @IBOutlet var opBullet2: UIImageView!
    @IBOutlet var opBullet3: UIImageView!
    
    @IBOutlet weak var myCharacter: APNGImageView!
    @IBOutlet weak var opCharacter: APNGImageView!
    
    @IBAction func didSensorAction(segue:UIStoryboardSegue) {}
    
    @IBAction func doSensorAction(sender: AnyObject) {
        if (self.passedDuel.myTurn.value) {
            self.performSegueWithIdentifier("doSensorAction", sender: self)
        }
    }
    var passedDuel: Duel!
    @IBOutlet weak var myActionLabel: UILabel!
    var passedResultCode: Int?
    var me: Actor?
    var op: Actor?
    
    @IBOutlet weak var opNick: UIBarButtonItem!
    var audioPlayer : AVAudioPlayer!

    @IBOutlet weak var opActionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Spinner.show()
        API.getDuel(passedDuel.id.value, userId: CurrentUser.getUser().id.value) { duel in
            Spinner.hide()
            self.passedDuel = duel
            self.configureView()
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.passedResultCode != nil) {
            let name = GestureManager.resultCodeToImageName(self.passedResultCode!)
            
            let path = NSBundle.mainBundle().pathForResource(name, ofType: "mp3")!
            let url = NSURL(fileURLWithPath: path)
            
            do {
                let sound = try AVAudioPlayer(contentsOfURL: url)
                audioPlayer = sound
                sound.play()
            } catch {
                
            }

            API.postAction(CurrentUser.getUser().id.value, duelId: self.passedDuel.id.value, actionType: GestureManager.resultCodeToActionType(self.passedResultCode!)) { duel in
                self.passedDuel = duel
                self.configureView()
            }
            
        }
        
    }
    
    func configureView() {
        self.me = self.passedDuel.me.value
        self.op = self.passedDuel.opponent.value

        self.opNick.title = self.op!.nick.value
        
        self.myActionLabel.text = !self.passedDuel.myTurn.value || !self.passedDuel.active.value ? GestureManager.actionTypeToImageName(self.passedDuel.myAction.value.type.value).uppercaseString : "YOUR TURN"
            
        self.opActionLabel.text = self.passedDuel.myTurn.value || !self.passedDuel.active.value ? GestureManager.actionTypeToImageName(self.passedDuel.opponentAction.value.type.value).uppercaseString : "WAITING"

        self.status.image = UIImage(named: self.passedDuel.result.value)
        
        self.setupBullets(myBullet1, b2: myBullet2, b3: myBullet3, bullets: self.me!.shots.value)
        self.setupBullets(opBullet1, b2: opBullet2, b3: opBullet3, bullets: self.op!.shots.value)
        
        self.myLifes.text = String(self.me!.hitPoints.value)
        self.opLifes.text = String(self.op!.hitPoints.value)
        
        let myImageName = (self.me?.characterName.value)! + "_blu_" + GestureManager.actionTypeToImageName(self.passedDuel.myAction.value.type.value)
        if let image = APNGImage(named: myImageName) {
            image.repeatCount = 0
            
            myCharacter.image = image
            myCharacter.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
            myCharacter.startAnimating()
        }
        
        let opImageName = (self.op?.characterName.value)! + "_red_" + GestureManager.actionTypeToImageName(self.passedDuel.opponentAction.value.type.value)
        if let image = APNGImage(named: opImageName) {
            image.repeatCount = 0
            
            opCharacter.image = image
            opCharacter.startAnimating()
        }
        
        
    }
    
    func setupBullets(b1: UIImageView, b2: UIImageView, b3: UIImageView, bullets: Int) {
        b1.image = UIImage(named: bullets > 0 ? "shoot_loaded" : "shoot_unloaded")
        b2.image = UIImage(named: bullets > 1 ? "shoot_loaded" : "shoot_unloaded")
        b3.image = UIImage(named: bullets > 2 ? "shoot_loaded" : "shoot_unloaded")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doSensorAction" {
            let sensorViewController = segue.destinationViewController as! SensorViewController
            sensorViewController.passedRoundNumber = self.passedDuel.roundCount.value
        }
    }
    
}