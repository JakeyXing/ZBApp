//
//  AppDelegate.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import CYLTabBarController
import IQKeyboardManagerSwift
import AWSCore
import AWSMobileClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mainTabBarVc: MainTabBarController!
    var usermodel: ZB_User?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LanguageHelper.shareInstance.initUserLanguage()
        mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        
        let accessToken = getAccessToken()

        let isLogin = accessToken == "" ? false : true
        if isLogin {
            if getUserStatus() == .review_pass{
                self.window?.rootViewController = mainTabBarVc
            }else{
                let reply = CertifApplyController()
                let naviVC = UINavigationController(rootViewController: reply)
                self.window?.rootViewController = naviVC
            }
    
        }else{
            let loginVC = LoginViewController()
            let naviVC = UINavigationController(rootViewController: loginVC)

            self.window?.rootViewController = naviVC
        }
//        let demo = DemoViewController()
//        let naviVC = UINavigationController(rootViewController: demo)
//        self.window?.rootViewController = naviVC
        
        self.window?.makeKeyAndVisible()
        
        //tabbar背景色
        UITabBar.appearance().backgroundColor = UIColor.white
        //tabbar字体颜色
        UITabBar.appearance().tintColor = kTintColorYellow
        IQKeyboardManager.shared.enable = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(reLogin), name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: nil)
        
        test()
        
        return AWSMobileClient.sharedInstance().interceptApplication(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
      
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func viewControllers() -> [UINavigationController]{
        let home = UINavigationController(rootViewController: HomeViewController())
        let unTakeMission = UINavigationController(rootViewController: UnTakeMissionViewController())
        let personal =   UINavigationController(rootViewController: PersonalViewController())
        let viewControllers = [home,unTakeMission, personal]
        
        return viewControllers
    }
    
    
    func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let tabBarItemOne = [CYLTabBarItemTitle:LanguageHelper.getString(key: "tabBar.title.pending"),
                             CYLTabBarItemImage:"tab_nor",
                             CYLTabBarItemSelectedImage:"tab_sel"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:LanguageHelper.getString(key: "tabBar.title.execute"),
                             CYLTabBarItemImage:"tab_nor",
                             CYLTabBarItemSelectedImage:"tab_sel"]
        
        let tabBarItemThree = [CYLTabBarItemTitle:LanguageHelper.getString(key: "tabBar.title.mine"),
                              CYLTabBarItemImage:"tab_nor",
                              CYLTabBarItemSelectedImage:"tab_sel"]
        let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo,tabBarItemThree]
        return tabBarItemsAttributes
    }
    
    
    //MARK: - actions
    @objc private func reLogin(){
        
        self.usermodel = nil
        
        let loginVC = LoginViewController()
        let naviVC = UINavigationController(rootViewController: loginVC)
        
        self.window?.rootViewController = naviVC
    }
    
    public func resetRootController() {
        mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        self.window?.rootViewController = mainTabBarVc
    }

    func test() {
        let str = "2【1  】2 3 -4  _5  8 年中国!!区块链产业白皮书(1)(1)(1)_77.pdf"
        let result = pathUrlEncode(path:pathUrlEncode(path: str))
        let res = result.replacingOccurrences(of: "%2520", with: "+")
        myPrint(items: res)
    }
}
