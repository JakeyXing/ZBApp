//
//  ZB_TaskProperty.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_TaskProperty: NSObject {
    @objc  var doorplate: String?
    @objc  var id: Int64 = 0
    @objc  var guideUrl: String?
    @objc  var maxGuests: Int = 0
    @objc  var nextCheckInDate: String?
    @objc  var nextCheckInNights: Int = 0
    @objc  var nextGuests: Int = 0
    @objc  var propertyName: String?
    @objc  var pwdInfos: [ZB_PwdInfo]?

    

    override var description: String {
        return yy_modelDescription()
    }
    private class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pwdInfos": ZB_PwdInfo.self]
    }
}
