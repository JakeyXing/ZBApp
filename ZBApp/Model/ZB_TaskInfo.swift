//
//  ZB_TaskInfo.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_TaskInfo: NSObject,YYModel {
    @objc  var address: ZB_Address?
    @objc  var associatedId: String?
    @objc  var desc: String?
    @objc  var documents: [String]?
    @objc  var hoursPerPerson: Int = 0
    @objc  var id: Int64 = 0
    @objc  var imgs: [String]?
    @objc  var properties: [ZB_TaskProperty]?
    @objc  var remark: String?
    @objc  var restHoursPerPerson: Int = 0
    @objc  var startDate: String?
    @objc  var title: String?
    @objc  var type: String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    private class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["properties": ZB_TaskProperty.self]
    }
}
