//
//  MissionDetailBaseViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit

class MissionDetailBaseViewController: UIViewController {

    lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = "任务详情"
//        view.bottomLine.isHidden = true
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: kResizedPoint(pt: 900))
        return view
    }()
    
    lazy var missionBaseInfoView: MissionBaseInfoView = {
        let view = MissionBaseInfoView(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: kResizedPoint(pt: 164)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.navigationBar.delegate = self
        self.view.addSubview(self.scrollview)
        self.scrollview.addSubview(self.missionBaseInfoView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MissionDetailBaseViewController:JHNavigationBarDelegate{
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightAction() {
        
    }
}
