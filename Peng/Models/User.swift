//
//  User.swift
//  Peng
//
//  Created by Yannick Schuchmann on 19.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper
import Bond

class User: Mappable {
    var id: Observable<Int> = Observable(0)
    var nick: Observable<String> = Observable("")
    var slogan: Observable<String> = Observable("")
    var duelsCount: Observable<Int> = Observable(0)
    var friendsCount: Observable<Int> = Observable(0)
    var rank: Observable<Int> = Observable(0)
    var characterId: Observable<Int> = Observable(0)
    var characterOrder: Observable<Int> = Observable(0)
    var characterName: Observable<String> = Observable("")
    var openDuels: ObservableArray<Duel> = ObservableArray([])
    
    required init?(_ map: Map){
        
    }
    
    init?() {
        
    }
        
    func mapping(map: Map) {
        id.value <- map["id"]
        slogan.value <- map["slogan"]
        duelsCount.value <- map["duels_count"]
        friendsCount.value <- map["friends_count"]
        rank.value <- map["rank"]
        characterId.value <- map["character_id"]
        characterOrder.value <- map["character_order"]
        characterName.value <- map["character_name"]
        nick.value <- map["nick"]
        openDuels.array <- map["open_duels"]
    }
}
