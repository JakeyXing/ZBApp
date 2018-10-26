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

func typeNameWithStr(str: String)-> String{
    var typeName = ""
    switch str {
    case "LAUNCH":
        typeName = LanguageHelper.getString(key: "home.dropDwon.launch")
    case "DISMANTLE":
        typeName = LanguageHelper.getString(key: "home.dropDwon.dismantle")
    case "MAINTAIN":
        typeName = LanguageHelper.getString(key: "home.dropDwon.maintain")
    case "CLEAN":
        typeName = LanguageHelper.getString(key: "home.dropDwon.clean")
    default:
        typeName = ""
    }
    return typeName

    
}


func configTypeParamWithStr(typeStr: String)-> String {
    var selectedType = ""
    
    if typeStr == "home.dropDwon.launch" {
        selectedType = "LAUNCH"
        
    }else if typeStr == "home.dropDwon.dismantle" {
        selectedType = "DISMANTLE"
        
    }else if typeStr == "home.dropDwon.maintain" {
        selectedType = "MAINTAIN"
        
    }else if typeStr == "home.dropDwon.clean" {
        selectedType = "CLEAN"
        
    }
    return selectedType
}

func statusNameWithStr(str: String)-> String{
    var typeName = ""
    switch str {
    case "READY":
        typeName = LanguageHelper.getString(key: "detail.status.ready")
    case "STARTED":
        typeName = LanguageHelper.getString(key: "detail.status.started")
    case "FINISHED":
        typeName = LanguageHelper.getString(key: "detail.status.finished")
    case "CANCELED":
        typeName = LanguageHelper.getString(key: "detail.status.canceled")
    default:
        typeName = ""
    }
    return typeName
    
}


func configStatusParamWithStr(typeStr: String)-> String {
    var selectedType = ""
    
    if typeStr == "detail.status.ready" {
        selectedType = "READY"
        
    }else if typeStr == "detail.status.started" {
        selectedType = "STARTED"
        
    }else if typeStr == "detail.status.finished" {
        selectedType = "FINISHED"
        
    }else if typeStr == "detail.status.canceled" {
        selectedType = "CANCELED"
        
    }
    return selectedType
}


//MARK: -时间转时间戳函数
func timeToTimeStamp(time: String) -> Double {
    let dfmatter = DateFormatter()
    //yyyy-MM-dd HH:mm:ss
    dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
    let last = dfmatter.date(from: time)
    let timeStamp = last?.timeIntervalSince1970
    return timeStamp ?? 0
}

//MARK: -时间戳转时间函数（只有日期）
func timeStampToString(timeStamp: Double)->String {
    //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
    let timeSta:TimeInterval = TimeInterval(timeStamp)
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmatter = DateFormatter()
    //yyyy-MM-dd
    dfmatter.dateFormat="yyyy-MM-dd"
    print(dfmatter.string(from: date as Date))
    return dfmatter.string(from: date as Date)
}


//MARK: -时间戳转“09：00”
func timeStampShortTimeStr(timeStamp: Double) -> String {
    let timeSta:TimeInterval = TimeInterval(timeStamp)
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmatter = DateFormatter()
    //
    dfmatter.dateFormat="HH:mm"
    return dfmatter.string(from: date as Date)
}

//MARK: -时间戳转“MM-dd 09：00”
func timeStampShortHourStr(timeStamp: Double) -> String {
    let timeSta:TimeInterval = TimeInterval(timeStamp)
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmatter = DateFormatter()
    //
    dfmatter.dateFormat="MM-dd HH:mm"
    return dfmatter.string(from: date as Date)
}

func getFormatRemainTime(secounds:TimeInterval)->String{
    if secounds.isNaN{
        return "0m"
    }
    let day = floor(secounds/(3600*24))
    let hour = floor(secounds.truncatingRemainder(dividingBy: 3600*24)  / 3600)
    let minutes = floor(secounds.truncatingRemainder(dividingBy: 3600) / 60)
    
    if day == 0 {
        return String(format: "%02dh%02m", hour, minutes)
    }else{
        return String(format: "%02dd%02dh%02m", day, hour, minutes)
    }
    
}




extension String {
    
    func md5WithSalt(salt:String) -> String {
        let encStr = self + salt
        let cStrl = encStr.cString(using: String.Encoding.utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String.uppercased();
    }
    

    
}
