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
    @objc  var propertyId: Int64 = 0
    @objc  var propertyName: String?
    
    
    
    
    override var description: String {
        return yy_modelDescription()
    }
}
