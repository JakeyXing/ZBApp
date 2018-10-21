//
//  MissionDetailBaseViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast

class MissionDetailBaseViewController: UIViewController {

    var taskExecuteId: Int64 = 0
    lazy var task: ZB_Task = ZB_Task()
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
        view.addressLabel.isUserInteractionEnabled = true
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(addressTapped))
        view.addressLabel.addGestureRecognizer(tap)
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
        self.loadNewData()
    }
    
    //MARK: - actions
    
    @objc private func addressTapped(){
        let map=MapViewController()
        map.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    
    func loadNewData() {
        
        let params = ["taskExecuteId":self.taskExecuteId] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .post, url: TaskDetailUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
            
            let model: ZB_Task = (NSObject.yy_model(withJSON: dic as Any) as? ZB_Task)!
            
            self.task = model
            
            self.configData()
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    

    func configData() {
        
    }

}

extension MissionDetailBaseViewController:JHNavigationBarDelegate{
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightAction() {
        
    }
}
