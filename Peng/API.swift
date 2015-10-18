//
//  API.swift
//  Peng
//
//  Created by Yannick Schuchmann on 18.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import Alamofire


class API {
    static let host: String = "http://api.peng.furfm.de"
    static let prefix: String = "/api/v1"
    
    class func getUrl() -> String {
        return self.host + self.prefix
    }
    
    class func loginFacebook(uid: String, token: String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        let params = ["uid": uid, "token": token]
        Alamofire.request(.POST, self.getUrl() + "/users/login_facebook", parameters: params)
            .responseJSON { response in
                completionHandler(response.result.value as? NSDictionary, response.result.error as? NSError)
        }
    }
}