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
    var itemIndex: Int = 0
    var character: Character = Character()
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterName.text = character.name.value
        self.characterDescription.text = character.description.value
        self.characterImage.image = UIImage(named: "character_" + character.name.value) 
    }
}