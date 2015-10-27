//
//  API.swift
//  Peng
//
//  Created by Yannick Schuchmann on 18.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class API {
    static let host: String = "http://api.peng.furfm.de"
    static let prefix: String = "/api/v1"
    static let updatePath: String = "https://peng.furfm.de/ios/update"
    
    class func getUrl() -> String {
        return self.host + self.prefix
    }
    
    class func loginFacebook(uid: String, token: String, completionHandler: (User) -> Void) {
        let params = ["uid": uid, "token": token]
        Alamofire.request(.POST, self.getUrl() + "/users/login_facebook", parameters: params)
            .responseObject { (response: User?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func updateUser(user: User, completionHandler: (User) -> Void) {
        let params = ["nick": user.nick.value, "slogan": user.slogan.value, "character_id": String(user.characterId.value)]
        Alamofire.request(.PUT, self.getUrl() + "/users/" + String(user.id.value), parameters: params)
            .responseObject { (response: User?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func getUsers(completionHandler: ([User]) -> Void) {
        Alamofire.request(.GET, self.getUrl() + "/users")
            .responseArray { (response: [User]?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func getCharacters(completionHandler: ([Character]) -> Void) {
        Alamofire.request(.GET, self.getUrl() + "/characters")
            .responseArray { (response: [Character]?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func getAppManifest(completionHandler: (AnyObject) -> Void) {
        Alamofire.request(.GET, "https://peng.furfm.de/ios/manifest.plist")
            .responsePropertyList { (response) in
                completionHandler(response.result.value!)
            
        }
    }
    
    class func postDuel(userId: Int, opponentId: Int, completionHandler: (Duel) -> Void) {
        Alamofire.request(.POST, self.getUrl() + "/duels", parameters:
            ["user_id" : userId, "opponent_id": opponentId])
            .responseObject { (response: Duel?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func postRandomDuel(userId: Int, completionHandler: (Duel) -> Void) {
        Alamofire.request(.POST, self.getUrl() + "/duels/random", parameters: ["user_id" : userId])
            .responseObject { (response: Duel?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func getDuel(duelId: Int, userId: Int, completionHandler: (Duel) -> Void) {
        Alamofire.request(.GET, self.getUrl() + "/duels/" + String(duelId), parameters: ["user_id": userId])
            .responseObject { (response: Duel?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
    class func getUser(userId: Int, completionHandler: (User) -> Void) {
        Alamofire.request(.GET, self.getUrl() + "/users/" + String(userId))
            .responseObject { (response: User?, error: ErrorType?) -> Void in
                if (error == nil) {
                    completionHandler(response!)
                }
        }
    }
    
}