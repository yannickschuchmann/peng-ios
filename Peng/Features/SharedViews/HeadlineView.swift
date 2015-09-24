//
//  HeadlineView.swift
//  Peng
//
//  Created by Yannick Schuchmann on 24.09.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import UIKit

@IBDesignable class HeadlineView: UIView {

    @IBOutlet weak var HeadLabel: UILabel!
    var view: UIView!
    
    @IBInspectable var Label: String = "Headline" {
        didSet {
            HeadLabel.text = Label
        }
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        //view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "HeadlineView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil).first as? UIView

        return view!
    }
    
    
}
