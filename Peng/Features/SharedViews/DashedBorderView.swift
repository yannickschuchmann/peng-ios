//
//  DashedLine.swift
//  Peng
//
//  Created by Yannick Schuchmann on 23.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation

class DashedBorderView: UIView {
    
    var _border:CAShapeLayer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _border = CAShapeLayer();
        
        _border.strokeColor = UIColor.whiteColor().CGColor;
        _border.fillColor = nil;
        _border.lineDashPattern = [4, 4];
        self.layer.addSublayer(_border);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:8).CGPath;
        _border.frame = self.bounds;
    }
}