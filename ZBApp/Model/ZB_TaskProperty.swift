//
//  ZB_TaskProperty.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import HandyJSON
class ZB_TaskProperty: HandyJSON {
    var doorplate: String?
    var id: Int64 = 0
    var guideUrl: String?
    var maxGuests: Int = 0
    var nextCheckInDate: String?
    var nextCheckInNights: Int = 0
    var nextGuests: Int = 0
    var propertyName: String?
    var pwdInfos: [ZB_PwdInfo]?
    
    
//    @objc  var doorplate: String?
//    @objc  var id: Int64 = 0
//    @objc  var guideUrl: String?
//    @objc  var maxGuests: Int = 0
//    @objc  var nextCheckInDate: String?
//    @objc  var nextCheckInNights: Int = 0
//    @objc  var nextGuests: Int = 0
//    @objc  var propertyName: String?
//    @objc  var pwdInfos: [ZB_PwdInfo]?
//
//
//
//    override var description: String {
//        return yy_modelDescription()
//    }
//    @objc private func modelContainerPropertyGenericClass() -> [String: AnyClass] {
//        return ["pwdInfos": ZB_PwdInfo.self]
//    }
    
    required init() {}
}
