//
//  ZB_TaskLog.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_TaskLog: NSObject,YYModel {
    
    @objc  var date: String?
    @objc  var task_description: String?
    @objc  var id: Int64 = 0
    @objc  var imgs: [String]?
    @objc  var type: String?
    @objc  var userId: Int64 = 0
    @objc  var userRole: String?
    @objc  var username: String?

    private func modelCustomPropertyMapper() -> [String : Any]? {
        return ["task_description":"description"]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}
