//
//  GestureManager.swift
//  Peng
//
//  Created by Yannick Schuchmann on 30.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation

class GestureManager {
    class func resultCodeToActionType(code : Int) -> String {
        var actionType : String
        switch code {
        case 0:
            actionType = "defensive"
        case 1:
            actionType = "offensive"
        case 2:
            actionType = "neutral"
        default:
            actionType = "defensive"
        }
        return actionType
    }
    
    class func actionTypeToImageName(type : String) -> String {
        var imageName : String
        switch type {
        case "defensive":
            imageName = "block"
        case "offensive":
            imageName = "shoot"
        case "neutral":
            imageName = "reload"
        default:
            imageName = type
        }
        return imageName
    }
    
    class func resultCodeToImageName(code: Int) -> String {
        return self.actionTypeToImageName(self.resultCodeToActionType(code))
    }
}