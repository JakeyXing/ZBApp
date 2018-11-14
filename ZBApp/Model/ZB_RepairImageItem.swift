//
//  ZB_RepairImageItem.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/31.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_RepairImageItem: Mappable{
    var doorplate: String?
    var propertyId: Int64 = 0
    var photos: [ZB_UploadImageItem]?//自己用
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        doorplate          <- map["doorplate"]
        propertyId       <- map["propertyId"]
    }
    
}
