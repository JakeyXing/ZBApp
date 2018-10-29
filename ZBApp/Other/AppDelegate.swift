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
        mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        
//        let isLogin = false
//        if isLogin {
//            self.window?.rootViewController = mainTabBarVc
//        }else{
//            let loginVC = LoginViewController()
//            let naviVC = UINavigationController(rootViewController: loginVC)
//
//            self.window?.rootViewController = naviVC
//        }
        let demo = DemoViewController()
        let naviVC = UINavigationController(rootViewController: demo)
        self.window?.rootViewController = naviVC
        
        self.window?.makeKeyAndVisible()
        
        //tabbar背景色
        UITabBar.appearance().backgroundColor = UIColor.white
        //tabbar字体颜色
        UITabBar.appearance().tintColor = UIColor(red: 255, green: 102, blue: 0, alpha: 1)
        IQKeyboardManager.shared.enable = true
        
      
        LanguageHelper.shareInstance.initUserLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(reLogin), name: NSNotification.Name(rawValue: kRefreshTokenInvalidNoti), object: nil)
        
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
        
        let tabBarItemOne = [CYLTabBarItemTitle:"首页",
                             CYLTabBarItemImage:"home_normal",
                             CYLTabBarItemSelectedImage:"home_highlight"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:"任务",
                             CYLTabBarItemImage:"mycity_normal",
                             CYLTabBarItemSelectedImage:"mycity_highlight"]
        
        let tabBarItemThree = [CYLTabBarItemTitle:"我的",
                              CYLTabBarItemImage:"account_normal",
                              CYLTabBarItemSelectedImage:"account_highlight"]
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

}
