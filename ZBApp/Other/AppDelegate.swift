//
//  AppDelegate.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import CYLTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainTabBarVc = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        self.window?.rootViewController = mainTabBarVc
        self.window?.makeKeyAndVisible()
        
        //tabbar背景色
        UITabBar.appearance().backgroundColor = UIColor.white
        //tabbar字体颜色
        UITabBar.appearance().tintColor = UIColor(red: 255, green: 102, blue: 0, alpha: 1)
        return true
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


}

