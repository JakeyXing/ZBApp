//
//  ZB_User.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/19.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import YYModel

class ZB_User: NSObject {
    @objc var accessToken:String?//自己用
    @objc var refreshToken:String?//自己用
    
    @objc  var id: Int64 = 0
    @objc  var isDel: Bool = false
    @objc var nationality:String?
    @objc var password:String?
    @objc var phoneNo:String?
    @objc var sex:String?
    @objc var userImgUrl:String?
    @objc var userLevel:String?
    @objc var userName:String?
    @objc var userScore:Int = 0
    @objc var userStatus:String?
    @objc var validNo:String?
    @objc var validNoImgUrl:String?
    @objc var validType:String?
    @objc var visaImgUrl:String?
    @objc var workCity:String?

    override var description: String {
        return yy_modelDescription()
    }
}
