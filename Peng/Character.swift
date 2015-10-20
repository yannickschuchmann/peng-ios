//
//  Character.swift
//  Peng
//
//  Created by Yannick Schuchmann on 20.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import ObjectMapper
import Bond

class Character: Mappable {
    var id: Observable<Int> = Observable(0)
    var name: Observable<String> = Observable("")
    var description: Observable<String> = Observable("")
    var order: Observable<Int> = Observable(0)
    
    required init?(_ map: Map){
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        id.value <- map["id"]
        name.value <- map["name"]
        description.value <- map["description"]
        order.value <- map["order"]
    }

}