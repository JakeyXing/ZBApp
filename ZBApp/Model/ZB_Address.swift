//
//  ZB_Address.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_Address: Mappable {
    var id: Int64 = 0
    var latitude: Float = 0
    var longitude: Float = 0
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        latitude       <- map["latitude"]
        longitude <- map["longitude"]
        name <- map["name"]
        
    }
    
    
//    override var description: String {
//        return yy_modelDescription()
//    }
    
    
}
