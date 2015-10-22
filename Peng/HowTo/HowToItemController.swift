//
//  HowToItemController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 22.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation

import UIKit

class HowToItemController: UIViewController {
    var itemIndex: Int = 0 
    var imageName: String = ""
    
    @IBOutlet weak var howToImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.howToImage.image = UIImage(named: self.imageName)
     }
}