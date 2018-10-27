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
    var isTaked = false  //是否被自己抢了
    
    var currentProgress:ZB_ProgressType = .ready
    
    var model: ZB_TaskInfo?
    lazy var task: ZB_Task = ZB_Task()//自己请求的
    
    lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "detail.nav.title")
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
        self.addSubViews()
        
        if self.isTaked == false {
            self.setupDataWithHomeModel()
        }else{
          self.loadNewDataWithId(taskId: self.taskExecuteId)
        }
        
    }
    
    func addSubViews() {
        print("子类在这添加subview")
        self.view.addSubview(self.navigationBar)
        self.navigationBar.delegate = self
        self.view.addSubview(self.scrollview)
        self.scrollview.addSubview(self.missionBaseInfoView)
        
    }
    
    //MARK: - actions
    
    @objc private func addressTapped(){
        let map=MapViewController()
        map.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    func loadNewDataWithId(taskId: Int64) {
        
        let params = ["taskExecuteId":taskId] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .get, url: TaskDetailUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
            
//            let model: ZB_Task = (NSObject.yy_model(withJSON: dic as Any) as? ZB_Task)!
            let model =  ZB_Task.yy_model(with: dic as! [AnyHashable : Any])
            
            
            self.task = model ?? ZB_Task()
            
            self.configData()
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    

    func configData() {
        print("子类必须实现")
    }
    
    //从首页传过来的model
    func setupDataWithHomeModel(){
        print("子类必须实现")
        
    }

}

extension MissionDetailBaseViewController:JHNavigationBarDelegate{
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightAction() {
        
    }
}
