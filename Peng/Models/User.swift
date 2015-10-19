//
//  User.swift
//  Peng
//
//  Created by Yannick Schuchmann on 19.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int?
    var nick: String?
    var slogan: String?
    var duelsCount: Int?
    var friendsCount: Int?
    var rank: Int?
    var characterId: Int?
    var characterOrder: Int?
    var characterName: String?
    
    required init?(_ map: Map){
        
    }
    
    init?() {
        
    }
        
    func mapping(map: Map) {
        id <- map["id"]
        nick <- map["nick"]
        slogan <- map["slogan"]
        duelsCount <- map["duels_count"]
        friendsCount <- map["friends_count"]
        rank <- map["rank"]
        characterId <- map["character_id"]
        characterOrder <- map["character_order"]
        characterName <- map["character_name"]
    }
}
