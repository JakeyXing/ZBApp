//
//  MainTabBarController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/8.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import CYLTabBarController
import AFNetworking

var networkType:String = ""

class MainTabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getI18n()
        
        let reachabilityManager = AFNetworkReachabilityManager.shared()
        reachabilityManager.startMonitoring()
        reachabilityManager.setReachabilityStatusChange { (status) in
            switch status {
            case .unknown:
                print("未识别网络")
                networkType = "Unknow"
            case .reachableViaWWAN:
                print("移动网络")
                networkType = "WWAN"
            case .reachableViaWiFi:
                print("Wi-Fi网络")
                networkType = "Wi-Fi"
            case .notReachable:
                print("网络不可达")
                networkType = "NotReachable"
            }
        }
        
    }
    

    func getI18n() {
        NetWorkManager.shared.loadRequest(method: .get, url: I18nUrl,parameters: nil, success: { (data) in
            let resultDic = data as! Dictionary<String,AnyObject>
            if let dic = resultDic["data"]{
                let i18n = dic["photoRefs"] as! Dictionary<String,AnyObject>
                let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                sharedAppdelegate.langDic = i18n[getCurrentLangParam()] as! Dictionary<String,String>
                myPrint(items: sharedAppdelegate.langDic["room"])
            }
        }) { (data, errMsg) in
        }
    }
}


extension MainTabBarController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        return true
    }
    
}
