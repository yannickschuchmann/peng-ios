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
    
    required init?(_ map: Map){
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        id.value <- map["id"]
    }
    
}