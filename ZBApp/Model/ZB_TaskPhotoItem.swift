//
//  ZB_TaskPhotoItem.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_TaskPhotoItem: NSObject,YYModel {
    @objc  var location: String?
    @objc  var photos: [ZB_Photo]?
    @objc  var total: Int = 0
    
    
    
    private class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["photos": ZB_Photo.self]
    }
}
