//
//  Action.swift
//  Peng
//
//  Created by Yannick Schuchmann on 30.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper
import Bond

class Action: Mappable {
    var type: Observable<String> = Observable("")
    
    required init?(_ map: Map){
        
    }
    
    init?() {
        
    }
    
    
    func mapping(map: Map) {
        type.value <- map["type"]
    }
}