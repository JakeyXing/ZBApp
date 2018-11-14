//
//  ZB_UploadImageItem.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/24.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper

enum UploadMediaType {
    case image, video
}

class ZB_UploadImageItem: Mappable{
   var doorplate: String?
   var propertyId: Int64 = 0
   var url: String?
    
    var videoPicName: String?////
    var mediaType = UploadMediaType.image
  

    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        doorplate          <- map["doorplate"]
        propertyId       <- map["propertyId"]
        url <- map["url"]
        
    }

}
