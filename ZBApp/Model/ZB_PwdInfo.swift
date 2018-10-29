//
//  ZB_PwdInfo.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/26.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_PwdInfo: Mappable {
    var desc: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        desc          <- map["desc"]
        type       <- map["type"]
        
    }

}
