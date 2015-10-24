//
//  Actor.swift
//  Peng
//
//  Created by Yannick Schuchmann on 25.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper
import Bond

class Actor: Mappable {
    var id: Observable<Int> = Observable(0)
    var nick: Observable<String> = Observable("")
    var userId: Observable<Int> = Observable(0)
    var hitPoints: Observable<Int> = Observable(0)
    var shots: Observable<Int> = Observable(0)
    var type: Observable<String> = Observable("")
    var characterName: Observable<String> = Observable("")
    
    required init?(_ map: Map){
        
    }
    
    init?() {
        
    }
    
    
    func mapping(map: Map) {
        id.value <- map["id"]
        userId.value <- map["user_id"]
        nick.value <- map["nick"]
        hitPoints.value <- map["hit_points"]
        shots.value <- map["shots"]
        type.value <- map["type"]
        characterName.value <- map["character_name"]
    }
}