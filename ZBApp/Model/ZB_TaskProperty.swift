//
//  ZB_TaskProperty.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_TaskProperty: Mappable {
    var doorplate: String?
    var id: Int64 = 0
    var guideUrl: String?
    var maxGuests: Int = 0
    var nextCheckInDate: String?
    var nextCheckInNights: Int = 0
    var nextGuests: Int = 0
    var propertyName: String?
    var pwdInfos: [ZB_PwdInfo]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        doorplate          <- map["doorplate"]
        id       <- map["id"]
        guideUrl <- map["guideUrl"]
        maxGuests <- map["maxGuests"]
        nextCheckInDate  <- map["nextCheckInDate"]
        nextCheckInNights <- map["nextCheckInNights"]
        nextGuests  <- map["nextGuests"]
        propertyName   <- map["propertyName"]
        pwdInfos  <- map["pwdInfos"]

        
    }

//
//
//
//    override var description: String {
//        return yy_modelDescription()
//    }
//    @objc private func modelContainerPropertyGenericClass() -> [String: AnyClass] {
//        return ["pwdInfos": ZB_PwdInfo.self]
//    }
    
 
}
