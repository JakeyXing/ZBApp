//
//  ZB_TaskInfo.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_TaskInfo: Mappable {
    
    var address: ZB_Address?
    var associatedId: String?
    var desc: String?
    var documents: [String]?
    var hoursPerPerson: Int = 0
    var id: Int64 = 0
    var imgs: [String]?
    var properties: [ZB_TaskProperty]?
    var remark: String?
    var restHoursPerPerson: Int = 0
    var restHours: Int = 0
    var startDate: String?
    var title: String?
    var type: String?
    var base: Float = 0
    var bonus: Float = 0
    var currency: String?
    var status: String?
 
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        address          <- map["address"]
        associatedId       <- map["associatedId"]
        desc <- map["desc"]
        documents <- map["documents"]
        hoursPerPerson  <- map["hoursPerPerson"]
        id <- map["id"]
        imgs  <- map["imgs"]
        properties   <- map["properties"]
        remark  <- map["remark"]
        restHoursPerPerson     <- map["restHoursPerPerson"]
        restHours  <- map["restHours"]
        startDate      <- map["startDate"]
        title     <- map["title"]
        type       <- map["type"]
        base       <- map["base"]
        bonus       <- map["bonus"]
        currency       <- map["currency"]
        status       <- map["status"]
        
    }

    
//    override var description: String {
//        return yy_modelDescription()
//    }
//
//    @objc func modelContainerPropertyGenericClass() -> [String: AnyClass] {
//        return ["properties": ZB_TaskProperty.self]
//    }
}
