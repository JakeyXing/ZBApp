//
//  MainTabBarController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/8.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import CYLTabBarController
class MainTabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}


extension MainTabBarController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        return true
    }
    
}
