//
//  Spinner.swift
//  Peng
//
//  Created by Yannick Schuchmann on 19.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

public class Spinner: UIView {
    public class var sharedInstance: Spinner {
        struct Singleton {
            static let instance = Spinner(frame: CGRect.zero)
        }
        return Singleton.instance
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = activityIndicatorViewStyle
        
        blurView.contentView.addSubview(actInd)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    public class func show() -> Spinner {
        let window = UIApplication.sharedApplication().windows.first!
        let spinner = Spinner.sharedInstance
        
        spinner.updateFrame()
        
        if spinner.superview == nil {
            //show the spinner
            spinner.alpha = 0.0
            window.addSubview(spinner)
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 1.0
                }, completion: nil)
            
        }
        
        spinner.actInd.startAnimating()
        
        return spinner
    }
    
    public class func hide(completion: (() -> Void)? = nil) {
        let spinner = Spinner.sharedInstance
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if spinner.superview == nil {
            //    return
            }
            
            spinner.actInd.stopAnimating()
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 0.0
                }, completion: {_ in
                    spinner.alpha = 1.0
                    spinner.removeFromSuperview()
                    
                    completion?()
                }
            )
            
        })
    }
    
    public func updateFrame() {
        let window = UIApplication.sharedApplication().windows.first!
        Spinner.sharedInstance.frame = window.frame
        
        
    }
    
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zero {
                return
            }
            blurView.frame = bounds
            actInd.center = center
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - Private interface
    
    //
    // layout elements
    //
    
    private var blurEffectStyle: UIBlurEffectStyle = .ExtraLight
    private var blurEffect: UIBlurEffect!
    private var blurView: UIVisualEffectView!
    public let actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    private let activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .Gray
    
}