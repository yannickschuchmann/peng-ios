//
//  DuelViewController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 26.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

class DuelViewController: UIViewController {
    
    
    @IBOutlet var myLifes: UILabel!
    @IBOutlet var opLifes: UILabel!
    
    @IBOutlet var myBullet1: UIImageView!
    @IBOutlet var myBullet2: UIImageView!
    @IBOutlet var myBullet3: UIImageView!
    
    @IBOutlet var opBullet1: UIImageView!
    @IBOutlet var opBullet2: UIImageView!
    @IBOutlet var opBullet3: UIImageView!
    
    @IBOutlet weak var myCharacter: UIImageView!
    @IBOutlet weak var opCharacter: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}