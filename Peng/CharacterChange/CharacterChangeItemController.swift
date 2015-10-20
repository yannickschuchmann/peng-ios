//
//  CharacterChangeController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 20.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation

import UIKit

class CharacterChangeItemController: UIViewController {
    var itemIndex: Int = 0 // ***
    var character: String = ""  // ***
    
    @IBOutlet weak var characterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterName.text = character
    }
}