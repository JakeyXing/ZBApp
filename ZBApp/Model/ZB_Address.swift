//
//  ZB_Address.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_Address: NSObject {
    @objc  var address: String?
    @objc  var addressEn: String?
    @objc  var city: String?
    @objc  var country: String?
    @objc  var id: Int64 = 0
    @objc  var latitude: Float = 0
    @objc  var longitude: Float = 0
    
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
}
