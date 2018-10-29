//
//  ZB_UploadImageItem.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/24.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_UploadImageItem: Mappable{
   var doorplate: String?
   var propertyId: String?
   var url: String?
  

    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        doorplate          <- map["doorplate"]
        propertyId       <- map["propertyId"]
        url <- map["url"]
        
    }

}
