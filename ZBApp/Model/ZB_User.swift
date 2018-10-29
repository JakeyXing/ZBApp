//
//  ZB_User.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/19.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper
class ZB_User: Mappable {

   var id: Int64 = 0
   var isDel: Bool = false
   var nationality:String?
   var password:String?
   var phoneNo:String?
   var sex:String?
   var userImgUrl:String?
   var userLevel:String?
   var userName:String?
   var userScore:Int = 0
   var userStatus:String?
   var validNo:String?
   var validNoImgUrl:String?
   var validType:String?
   var visaImgUrl:String?
   var workCity:String?
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        isDel       <- map["isDel"]
        nationality <- map["nationality"]
        password    <- map["password"]
        phoneNo     <- map["phoneNo"]
        sex         <- map["sex"]
        userImgUrl  <- map["userImgUrl"]
        userLevel   <- map["userLevel"]
        userName    <- map["userName"]
        userScore   <- map["userScore"]
        userStatus  <- map["userStatus"]
        validNo     <- map["validNo"]
        validNoImgUrl  <- map["validNoImgUrl"]
        validType      <- map["validType"]
        visaImgUrl     <- map["visaImgUrl"]
        workCity       <- map["workCity"]
    
    }

}
