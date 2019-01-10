//
//  ZB_Photo.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_Photo: Mappable {
    var url: String?
    var index: Int = 0
    var position: String?
    var location: String?
    var refUrl: String?
    var upload = false
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        url          <- map["url"]
        index       <- map["index"]
        position <- map["position"]
        location <- map["location"]
        refUrl  <- map["refUrl"]
        
    }
    
//
//    override var description: String {
//        return yy_modelDescription()
//    }


}
