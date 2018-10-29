//
//  ZB_TaskInfo.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import HandyJSON
class ZB_TaskInfo: HandyJSON {
//    @objc  var address: ZB_Address?
//    @objc  var associatedId: String?
//    @objc  var desc: String?
//    @objc  var documents: [String]?
//    @objc  var hoursPerPerson: Int = 0
//    @objc  var id: Int64 = 0
//    @objc  var imgs: [String]?
//    @objc  var properties: [ZB_TaskProperty]?
//    @objc  var remark: String?
//    @objc  var restHoursPerPerson: Int = 0
//    @objc  var restHours: Int = 0
//    @objc  var startDate: String?
//    @objc  var title: String?
//    @objc  var type: String?
//    @objc  var base: Float = 0
//    @objc  var bonus: Float = 0
//    @objc  var currency: String?
//    @objc  var status: String?
    

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
 
   required init() {}

    
//    override var description: String {
//        return yy_modelDescription()
//    }
//
//    @objc func modelContainerPropertyGenericClass() -> [String: AnyClass] {
//        return ["properties": ZB_TaskProperty.self]
//    }
}
