//
//  ZB_TaskLog.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_TaskLog: Mappable {
    
    var date: String?
    var log_description: String?
    var id: Int64 = 0
    var imgs: [String]?
    var reason: String?
    var type: String?
    var userId: Int64 = 0
    var userRole: String?
    var username: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        date          <- map["date"]
        log_description       <- map["description"]
        id <- map["id"]
        imgs  <- map["imgs"]
        reason   <- map["reason"]
        type  <- map["type"]
        userId     <- map["userId"]
        userRole  <- map["userRole"]
        username      <- map["username"]
        
    }
//
//    private func modelCustomPropertyMapper() -> [String : Any]? {
//        return ["log_description":"description"]
//    }
//
//    override var description: String {
//        return yy_modelDescription()
//    }
}
