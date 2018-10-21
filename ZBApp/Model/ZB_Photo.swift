//
//  ZB_Photo.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_Photo: NSObject {
    @objc  var imgUrl: String?
    @objc  var phIndex: Int = 0
    @objc  var position: String?
    @objc  var reason: String?
    @objc  var refImgUrl: String?
    
  
    override var description: String {
        return yy_modelDescription()
    }


}
