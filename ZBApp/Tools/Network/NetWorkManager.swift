//
//  NetWorkManager.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/19.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType {
    case get
    case post
}

let kDefaultTimeout:TimeInterval = 15

class NetWorkManager: AFHTTPSessionManager {

    static let shared:NetWorkManager = {
    
        let instance = NetWorkManager(baseURL: URL(fileURLWithPath: BaseApiUrl))
        instance.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        instance.requestSerializer = AFJSONRequestSerializer()
        instance.responseSerializer = AFJSONResponseSerializer()
        instance.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "application/json", "text/plain", "text/javascript", "text/json", "text/html")
        instance.requestSerializer.timeoutInterval = kDefaultTimeout
        return instance
    }()
    
    //登录 注册（不需要token）
    func loadNoTokenRequest(method :RequestType,
                            url : String,
                     parameters : [String:Any]?,
                     success : @escaping(_ json:Any?)->(),
                     fail : @escaping(_ json:Any?,_ errMsg:String)->())  {
        
        request(method: method, url: url, parameters: parameters, success: { (json) in
            guard let jsonData = json else {
                fail(nil,"response data is nil")
                return
            }
            let resultDic = jsonData as! Dictionary<String,AnyObject>
            let code:String = resultDic["code"] as! String
            if code == "200" {
                success(json)
            }else{
                fail(json,resultDic["msg"] as! String)
            }
            
        }) { (errMsg) in
            fail(nil,errMsg)
        }
        
    }
    
    
    
    //普通请求
    func loadRequest(method :RequestType,
                     url : String,
                 parameters : [String:Any]?,
                 success : @escaping(_ json:Any?)->(),
                 fail : @escaping(_ json:Any?,_ errMsg:String)->())  {
        
//        guard let token = m_AppDelegate().usermodel?.accessToken else {
//            print("token 为空")
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNoRefreshTokenNoti), object: nil)
//
//            fail(nil,"you need login first")
//            return
//        }
       let token = "4cl00Io2vYlMInLN7XSk44kdfbYa1hNf9CIA9nZBVWvuvy2EtiMHS441lrhJLDGOFFRTJCuhxiSpgsuGMQMZXktGXlyZkDpH"
        
        NetWorkManager.shared.requestSerializer.setValue(token, forHTTPHeaderField: "accessToken")
        request(method: method, url: url, parameters: parameters, success: { (json) in
            guard let jsonData = json else {
                fail(nil,"response data is nil")
                return
            }
            let resultDic = jsonData as! Dictionary<String,AnyObject>
            let code:String = resultDic["code"] as! String
            if code == "200" {
                success(json)
            }else{
                fail(json,resultDic["msg"] as! String)
            }
            
        }) { (errMsg) in
            fail(nil,errMsg)
        }
        
    }
    
    
    //基础请求
    func request(method :RequestType,
                 url : String,
                 parameters : [String:Any]?,
                 success : @escaping(_ json:Any?)->(),
                 fail : @escaping(_ errMsg:String)->() )  {
        
        
        print("\n\n\n**************************************\n\nURL    -> \(url)\n\nParams -> \(String(describing: parameters))\n\n**************************************\n\n\n")
        
        let success = { (task:URLSessionDataTask , json : Any?)->() in
           
            print("\n\n\n**************************************\n\nURL-> \(url) \n\nResult -> \(String(describing: json))\n\n**************************************\n\n\n")
            
            success(json)
        }
        
        let failure = { (task:URLSessionDataTask? , error : Error)->() in
            
            print("\n\n\n**************************************\n\nURL   -> \(url) \n\nError -> \(String(describing: error))\n\n**************************************\n\n\n")
            
            var errMsg = ""
            if (task?.response as? HTTPURLResponse)?.statusCode == 1001 {
                print("access token expired")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kAccessTokenTokenInvalidNoti), object: "access token expired")
                
                //重新获取access token
                let mana = AFHTTPSessionManager()
                mana.get(refreshAccessTokenApiUrl, parameters: [], progress: nil, success: { (dataTask, jsonData) in
                    
                    guard let jsonDa = jsonData else {
                        //无数据默认 refresh token 失效
                        print("refresh token expired")
                        errMsg = "refresh token expired"
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: "refresh token expired")
                        return
                    }
                    let resultDic = jsonDa as! Dictionary<String,AnyObject>
                    let code:String = resultDic["code"] as! String
                    if code == "200" {
                        
                        //accessToken 更新成功 刷新数据
                        errMsg = refreshData_msg
                        m_AppDelegate().usermodel?.accessToken = (resultDic["accessToken"] as! String)
                        m_AppDelegate().usermodel?.refreshToken = (resultDic["refreshToken"] as! String)
                       
                    }else{
                        //其他错误默认 refresh token 失效
                        errMsg = "refresh token expired"
                        print("refresh token expired")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: "refresh token expired")
                    }
                    
                }, failure: { (dataTask, err) in
                    
                    //请求失败默认 refresh token 失效
                    print("refresh token expired")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: "refresh token expired")
                    
                    
                })
                
            }else if (task?.response as? HTTPURLResponse)?.statusCode == 1002 {
                print("refresh token expired")
                errMsg = "refresh token expired"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: "refresh token expired")
                
            }else if (task?.response as? HTTPURLResponse)?.statusCode == 408 {
                print("request timeout")
                errMsg = "request timeout"
                
            }else{
                errMsg = "request failed"
            }
            
            fail(errMsg)
        }
        
        if method == RequestType.get {
            get(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            post(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
    

    
}
