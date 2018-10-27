//
//  UnTakeMissionViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import BEMCheckBox
import MJRefresh
import MBProgressHUD
import Toast

private let  kMissionCellID = "kMissionCellID"
class UnTakeMissionViewController: UIViewController {
    
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.backButton.isHidden = true
        return view
    }()
    
    private lazy var typeSegment: MissionSegmentBar = {
        let view = MissionSegmentBar(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: 44))
        view.delegate = self;
        return view
    }()
    
    private lazy var topBarBg: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: kResizedPoint(pt: 40)))
        return view
    }()
    
    let readyListController:TaskStatusViewController = TaskStatusViewController()
    let startedListController:TaskStatusViewController = TaskStatusViewController()
    let finishedListController:TaskStatusViewController = TaskStatusViewController()
    let canceledListController:TaskStatusViewController = TaskStatusViewController()
    
    private var currentVC:TaskStatusViewController!
    private var currentIndex = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.navigationBar.contentView.addSubview(self.typeSegment)
        
        readyListController.settedType = "READY"
        startedListController.settedType = "STARTED"
        finishedListController.settedType = "FINISHED"
        canceledListController.settedType = "CANCELED"
        
        self.addChild(readyListController)
        self.view.addSubview(readyListController.view)
        readyListController.didMove(toParent: self)
        
        readyListController.view.frame = CGRect.init(x: 0, y: navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight)
        startedListController.view.frame = CGRect.init(x: 0, y: navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight)
        finishedListController.view.frame = CGRect.init(x: 0, y: navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight)
        canceledListController.view.frame = CGRect.init(x: 0, y: navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight)
        
        currentVC = readyListController
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        readyListController.view.frame = CGRect.init(x: 0, y: navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight)
    }
    
    func changeController(fromVC:TaskStatusViewController,toViewController toVC:TaskStatusViewController) {
        self.addChild(toVC)
        
        self.transition(from: fromVC, to: toVC, duration: 0.3, options: .curveEaseIn, animations: {
            
        }) { (finished) in
            if finished {
                toVC.didMove(toParent: self)
                fromVC.willMove(toParent: self)
                fromVC.removeFromParent()
                
                self.currentVC = toVC
            }else{
                self.currentVC = fromVC
            }
            
        }
        
        
//        [self addChildViewController:newController];
//        /**
//         *  切换ViewController
//         */
//        [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
//
//            //做一些动画
//
//            } completion:^(BOOL finished) {
//
//            if (finished) {
//
//            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
//            [newController didMoveToParentViewController:self];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
//            currentVC = newController;
//
//            }else
//            {
//            currentVC = oldController;
//            }
//
//            }];
 
        
    }

}

extension UnTakeMissionViewController:MissionSegmentBarDelegate{
    func missionSegmentBar(_ segmentBar: MissionSegmentBar, didSelectedIndex index: NSInteger) {
        if currentIndex == index {
            return
        }
        
        currentIndex = index
        
        switch index {
        case 0:
            self.changeController(fromVC: currentVC, toViewController: readyListController)
        case 1:
            self.changeController(fromVC: currentVC, toViewController: startedListController)
        case 2:
            self.changeController(fromVC: currentVC, toViewController: finishedListController)
        case 3:
            self.changeController(fromVC: currentVC, toViewController: canceledListController)
        default:
            print("")
        }
        
        
        
    }
    
 
    
}
