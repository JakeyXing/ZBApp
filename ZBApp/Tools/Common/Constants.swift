//
//  Constants.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/9.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import Foundation
import UIKit

let DEVICE_WIDTH = UIScreen.main.bounds.size.width
let DEVICE_HEIGHT = UIScreen.main.bounds.size.height

let navigationBarHeight:CGFloat = IS_IPHONE_X() ? 88:64
let statusBarHeight:CGFloat = IS_IPHONE_X() ? 44:20
let tabbarExtraHeight:CGFloat = IS_IPHONE_X() ? 34 : 0
let tabbarHeight:CGFloat = IS_IPHONE_X() ? 83 : 49

//按iPhone6尺寸来
let kWidthRate = UIScreen.main.bounds.size.width/375.0
let kFontScale = UIScreen.main.bounds.size.width/375.0

func kResizedPoint(pt:CGFloat) -> CGFloat{
    return (pt) * kWidthRate
}

func kResizedFont(ft:CGFloat) -> CGFloat{
    return (ft) * kFontScale
}

func kFont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: kResizedFont(ft: size))
}

func kMediumFont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: kResizedFont(ft: size), weight: UIFont.Weight.medium)
}

func IS_IPHONE() -> Bool{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
}

func IS_IPHONE_X() -> Bool{
    return (IS_IPHONE() && DEVICE_WIDTH == 812.0)
}

func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

func RGBACOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

let kFontColorGray = RGBCOLOR(r: 108, 107, 102)
let kFontColorGray_177 = RGBCOLOR(r: 117, 117, 117)
let kTintColorYellow = RGBCOLOR(r: 255, 170, 35)
let kStateBarColorYellow = RGBCOLOR(r: 254, 153, 0)
let kBgColorGray_221 = RGBCOLOR(r: 221, 221, 221)
let kBgColorGray_238_235_220 = RGBCOLOR(r: 238, 235, 220)
let kFontColorBlack = RGBCOLOR(r: 32, 32, 32)

func m_AppDelegate() -> AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
}

