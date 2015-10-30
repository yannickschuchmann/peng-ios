//
//  Duel
//  Peng
//
//  Created by Yannick Schuchmann on 20.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper
import Bond

class Duel: Mappable {
    var id: Observable<Int> = Observable(0)
    var bet: Observable<String> = Observable("")
    var status: Observable<String> = Observable("")
    var result: Observable<String> = Observable("")
    var me: Observable<Actor> = Observable(Actor()!)
    var opponent: Observable<Actor> = Observable(Actor()!)
    var myTurn: Observable<Bool> = Observable(false)
    var myAction: Observable<Action> = Observable(Action()!)
    var opponentAction: Observable<Action> = Observable(Action()!)
    
    required init?(_ map: Map){
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        id.value <- map["id"]
        bet.value <- map["bet"]
        status.value <- map["status"]
        result.value <- map["result"]
        me.value <- map["me"]
        opponent.value <- map["opponent"]
        myTurn.value <- map["my_turn"]
        myAction.value <- map["my_action"]
        opponentAction.value <- map["opponent_action"]
    }
    
}