//
//  Constants.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/9.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import Foundation
import UIKit
import AWSCore
import AWSS3
import AWSCognito
import AFNetworking

enum ZB_ProgressType: String {
    case ready = "READY"
    case transfer = "TRANSFER"
    case started = "STARTED"
    case wail_approve = "WAIT_APPROVE"
    case approve_failed = "APPROVE_FAILED"
    case finished = "FINISHED"
    case abandon_transfer = "ABANDON_TRANSFER"
    case abandon_operate = "ABANDON_OPERATE"
    case finished_noshow = "FINISHED_NOSHOW"
    
}

enum ZB_UserStatus: String {
    case registred = "REGISTERED"
    case review_wait = "REVIEW_WAIT"
    case review_fail = "REVIEW_FAIL"
    case review_pass = "REVIEW_PASS"
    
}

let DEVICE_WIDTH = UIScreen.main.bounds.size.width
let DEVICE_HEIGHT = UIScreen.main.bounds.size.height

let navigationBarHeight:CGFloat = IS_IPHONE_X() ? 88:64
let statusBarHeight:CGFloat = IS_IPHONE_X() ? 44:20
let tabbarExtraHeight:CGFloat = IS_IPHONE_X() ? 34 : 0
let tabbarHeight:CGFloat = IS_IPHONE_X() ? 83 : 49

let kAccessTokenKey:String = "accessToken"
let krefreshTokenKey:String = "refreshToken"
let kUserInfoKey:String = "userInfoKey"

//https://s3-ap-northeast-1.amazonaws.com/ostay-clean/product/P_20181027_220318_cmp.jpg
let kAWSBaseUrl:String = "https://s3-ap-northeast-1.amazonaws.com/ostay-clean/"

func setAccessToken(token:String){
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: kAccessTokenKey)
}

func getAccessToken() -> String{
    let defaults = UserDefaults.standard
    
    guard let accessToken: String = defaults.value(forKey: kAccessTokenKey) as? String else {
        print("没这个key")
        return ""
    }
    
    if accessToken.isEmpty {
        return ""
    }else{
        return accessToken
    }
    
}

func setRefreshToken(token:String){
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: krefreshTokenKey)
    
}

func getRefreshToken() -> String{
    let defaults = UserDefaults.standard
    guard let refreshToken: String = defaults.value(forKey: krefreshTokenKey) as? String else {
        print("没这个key")
        return ""
    }
    if refreshToken.isEmpty {
        return ""
    }else{
        return refreshToken
    }
    
}

func setUserInfo(info:Dictionary<String, Any>){
    let defaults = UserDefaults.standard
    defaults.set(info, forKey: kUserInfoKey)
}

func getUserInfo() -> [String:Any]{
    let defaults = UserDefaults.standard
    
    guard let info: Dictionary = defaults.value(forKey: kUserInfoKey) as? [String:Any] else {
        print("没这个key")
        return [:]
    }
    
    if info.isEmpty {
        return [:]
    }else{
        return info
    }
    
}


func setUserStatus(status:String){
    let defaults = UserDefaults.standard
    
    guard let info: Dictionary = defaults.value(forKey: kUserInfoKey) as? [String:Any] else {
        print("没这个key")
       return
    }
    
    var userInfo = info
    userInfo["userStatus"] = status
    defaults.set(userInfo, forKey: kUserInfoKey)
    
}

func getUserStatus() -> ZB_UserStatus{
    let defaults = UserDefaults.standard
    guard let info: Dictionary = defaults.value(forKey: kUserInfoKey) as? [String:Any] else {
        print("没这个key")
        return .registred
    }
    
    guard let status:String = info["userStatus"] as? String else {
        return .registred
    }
    
    let userStaus = ZB_UserStatus(rawValue: status)
    return userStaus ?? .registred
}



func getCurrentLangParam() -> String {
    var lang = ""
    let langueStr = LanguageHelper.shareInstance.currentLanguageFileName ?? ""
    switch langueStr {
    case "zh-Hant":
        lang = "ZH"
    case "ja":
        lang = "JP"
    case "en":
        lang = "EN"
    default:
        lang = "ZH"
    }
    return lang
}

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
    case "WITHDRAWAL":
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
        selectedType = "WITHDRAWAL"
        
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

func progressNameWithProgress(progerss: ZB_ProgressType)-> String {
    switch progerss {
    case .ready:
        return LanguageHelper.getString(key: "detail.progress.ready")
    case .started:
        return LanguageHelper.getString(key: "detail.progress.started")
    case .transfer:
        return LanguageHelper.getString(key: "detail.progress.transfer")
    case .wail_approve:
        return LanguageHelper.getString(key: "detail.progress.wail_approve")
    case .approve_failed:
        return LanguageHelper.getString(key: "detail.progress.approve_failed")
    case .finished:
        return LanguageHelper.getString(key: "detail.progress.finished")
    case .finished_noshow:
        return LanguageHelper.getString(key: "detail.progress.finished_noshow")
    case .abandon_transfer:
        return LanguageHelper.getString(key: "detail.progress.abandon_transfer")
    case .abandon_operate:
        return LanguageHelper.getString(key: "detail.progress.abandon_operate")
    default:
        return ""
    }
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
    let now = Date().timeIntervalSince1970
    let remain = secounds - now
    if remain <= 0 {
        return "0m"
    }
    let day = floor(remain/(3600*24))
    let hour = floor(remain.truncatingRemainder(dividingBy: 3600*24)  / 3600)
    let minutes = floor(remain.truncatingRemainder(dividingBy: 3600) / 60)
    
    if day == 0 {
        return String(format: "%dh%dm", Int(hour), Int(minutes))
    }else{
        return String(format: "%dd%dh%dm", Int(day), Int(hour), Int(minutes))
    }
    
}

func getTransferManager(key:String,fileUrl:URL,retry:Bool) -> AWSS3TransferManager {
    let uploadRequest = AWSS3TransferManagerUploadRequest()
    uploadRequest?.bucket = "ostay-clean"
    uploadRequest?.key = key
    uploadRequest?.body = fileUrl
    uploadRequest?.acl = AWSS3ObjectCannedACL.publicRead
    uploadRequest?.uploadProgress = { (bytesSent, totalBytesSent, totalBytesExpectedToSend) -> Void in
        DispatchQueue.main.async(execute: {
            print("bytesSent ----> \(bytesSent); totalBytesSent ----> \(totalBytesSent); totalBytesExpectedToSend ----> \(totalBytesExpectedToSend)")
        })
    }
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.APNortheast1, identityPoolId:"us-east-1:4f288687-b535-414d-b9a3-abe2daf9b616")
    let configuration = AWSServiceConfiguration(region: AWSRegionType.APNortheast1, credentialsProvider: credentialsProvider)
    let anonymous = AWSServiceConfiguration(region: .APNortheast1, credentialsProvider: AWSAnonymousCredentialsProvider())
    if retry {
        configuration?.maxRetryCount = 3
        configuration?.timeoutIntervalForRequest = 20
        let service = AWSServiceManager.init()
        service.defaultServiceConfiguration = configuration
        let manager = AWSS3TransferManager.init()
        return manager
    }
    AWSServiceManager.default()?.defaultServiceConfiguration = configuration
    
    let client = AWSServiceManager()
    client.defaultServiceConfiguration = anonymous
    
    return AWSS3TransferManager.default()
}

let manager = AFHTTPSessionManager.init(baseURL: URL(string: "http://www.ostay.cc"))
//上传文件
func uploadDataToAWS(fileName : String,
                     filePath : String,
                     success : @escaping(_ fileUrl:String?)->(),
                     fail : @escaping(_ errMsg:String)->()){
    
    let key = "product/" + fileName
    
    let fileUrl = URL(fileURLWithPath: filePath )
    let uploadRequest = AWSS3TransferManagerUploadRequest()
    uploadRequest?.bucket = "ostay-clean"
    uploadRequest?.key = key
    uploadRequest?.body = fileUrl
    uploadRequest?.acl = AWSS3ObjectCannedACL.publicRead
    uploadRequest?.uploadProgress = { (bytesSent, totalBytesSent, totalBytesExpectedToSend) -> Void in
        DispatchQueue.main.async(execute: {
            print("bytesSent ----> \(bytesSent); totalBytesSent ----> \(totalBytesSent); totalBytesExpectedToSend ----> \(totalBytesExpectedToSend)")
        })
    }
    
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.APNortheast1, identityPoolId:"ap-northeast-1:55a61e5d-f0dd-4ce9-b4a9-ddc2824afc3e")
    let configuration = AWSServiceConfiguration(region: AWSRegionType.APNortheast1, credentialsProvider: credentialsProvider)
    //    let configuration = AWSServiceConfiguration(region: AWSRegionType.APNortheast1, credentialsProvider: AWSAnonymousCredentialsProvider())
    configuration?.maxRetryCount = 3
    configuration?.timeoutIntervalForRequest = 20
    AWSServiceManager.default().defaultServiceConfiguration = configuration
    let transferManager = AWSS3TransferManager.default()
    
    transferManager.upload(uploadRequest!).continueWith { (taskk: AWSTask) -> Any? in
        if taskk.error != nil {
            // Error.
            //            print("upload to s3 failed ==============================\(taskk.error.debugDescription)")
            let errorInfo = taskk.error.debugDescription
            print("upload to s3 failed ==============================\(errorInfo)")
            
            var params = getImageUploadMessage()
            params["server"] = "https://s3-ap-northeast-1.amazonaws.com"
            params["maxRetryCount"] = "3"
            params["timeoutInterval"] = "20"
            params["filePath"] = "https://s3-ap-northeast-1.amazonaws.com/ostay-clean/" + key
            
            let attr = try? FileManager.default.attributesOfItem(atPath: filePath)
            let fileSize = attr?[FileAttributeKey.size] as! UInt64
            params["fileSize"] = String(fileSize)
            params["reason"] = taskk.error.debugDescription
            myPrint(items: params)
            myPrint(items: params["deviceModel"]!)
            
            //        request.request(withMethod: "GET", urlString: "www.ostay.cc", parameters: params, error: nil)
            manager.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "text/html")
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.get("/crowd/client/debugerror/", parameters: params, progress: nil, success: { (urlSessionDataTask, any) in
                //                print("success")
            }) { (urlSessionDataTask, error) in
                //                print("error ----> \(error.localizedDescription)")
            }
            fail(taskk.error.debugDescription)
        } else {
            
            let url = kAWSBaseUrl + key
            print("Success :\(url)")
            success(url)
        }
        return nil
        
    }
    
}

func uploadToAWS(fileName : String,
                     filePath : String,
                     success : @escaping(_ fileUrl:String?)->(),
                     fail : @escaping(_ errMsg:String)->()){

    let key = "product/" + fileName

    let fileUrl = URL(fileURLWithPath: filePath )
    let data = try? Data(contentsOf: fileUrl)


    let expression = AWSS3TransferUtilityUploadExpression()
    expression.progressBlock = {(task, progress) in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Update a progress bar.
        })
    }

    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    completionHandler = { (task, error) -> Void in
        if error != nil {
            print("error\(error)")
        }
        let url = kAWSBaseUrl + key

        success("success:\(url)")
        DispatchQueue.main.async(execute: {
            // Do something e.g. Alert a user for transfer completion.
            // On failed uploads, `error` contains the error object.
        })
    }

    let transferUtility = AWSS3TransferUtility.default()
    
    transferUtility.uploadData(data!,
                               bucket: "ostay-clean",
                               key: key,
                               contentType: "application/x-jpg",
                               expression: expression,
                               completionHandler: completionHandler).continueWith {
                                (task) -> AnyObject! in
                                if let error = task.error {
                                    print("Error: \(error.localizedDescription)")
                                }

                                if let _ = task.result {
                                    // Do something with uploadTask.
                                }
                                return nil;
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

func pathUrlEncode(path :String) -> String {
    var chars = CharacterSet.urlQueryAllowed
    chars.insert("+")
    let result = path.addingPercentEncoding(withAllowedCharacters: chars)
    myPrint(items: result)
    return result!
}

func myPrint(items: Any...) {
    print("-----> \(items) <-----")
}

func getImageUploadMessage() -> Dictionary<String,String> {
    var message = [String:String]()
    message["deviceModel"] = UIDevice.current.deviceModel
    message["systemVersion"] = UIDevice.current.systemVersion
    let infoDic = Bundle.main.infoDictionary
    let appVersion = infoDic?["CFBundleShortVersionString"] // 获取App的版本
    let appBuildVersion = infoDic?["CFBundleVersion"] // 获取App的build版本
    let appName = infoDic?["CFBundleDisplayName"]
    message["appVersion"] = appVersion as? String
    message["appBuildVersion"] = appBuildVersion as? String
    message["appName"] = appName as? String
    message["networkType"] = networkType
    
    return message
}

extension UIDevice {
    var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        default:  return identifier
        }
    }
}
