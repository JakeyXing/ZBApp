//
//  ZB_TaskPhotoItem.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_TaskPhotoItem: Mappable {
    var location: String?
    var photos: [ZB_Photo]?
    var total: Int = 0
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        location          <- map["location"]
        photos       <- map["photos"]
        total <- map["total"]
        
    }
    
}
