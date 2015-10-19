//
//  CurrentUser.swift
//  Peng
//
//  Created by Yannick Schuchmann on 19.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper

public class CurrentUser {
    public class var sharedInstance: CurrentUser {
        struct Singleton {
            static let instance = CurrentUser()
        }
        return Singleton.instance
    }
    
    public init() {
        self.user = User()!
    }
    
    class func getUser() -> User {
        return CurrentUser.sharedInstance.user
    }

    class func setUser(user: User) -> Void {
        CurrentUser.sharedInstance.user = user
    }
    
    private var user: User
}