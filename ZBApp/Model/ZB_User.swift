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
    @objc var accessToken:String?
    @objc var refreshToken:String?
    
    
    
    

    override var description: String {
        return yy_modelDescription()
    }


}
