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
import ObjectMapper
import EasyTipView

class MissionDetailBaseViewController: UIViewController {

    var taskExecuteId: Int64 = 0
    var isTaked = false  //是否被自己抢了
    
    var currentProgress:ZB_ProgressType = .ready
    
    var model: ZB_TaskInfo?
    var task: ZB_Task?//自己请求的
    
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
        
        let tapp = UITapGestureRecognizer(target: self, action: #selector(addressTapped))
        view.addressIcon.isUserInteractionEnabled = true
        view.addressIcon.addGestureRecognizer(tapp)
        
        view.starImage_1.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(baseTip))
        view.starImage_1.addGestureRecognizer(tap1)
        
        view.starImage_2.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(bonusTip))
        view.starImage_2.addGestureRecognizer(tap2)
        
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
        if self.isTaked {
          map.address = task?.address
        }else{
           map.address = model?.address
        }
        map.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(map, animated: true)
    }
    

    @objc private func baseTip(){
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = kFont(size: 15)
        preferences.drawing.foregroundColor = kFontColorGray
        preferences.drawing.backgroundColor = kTintColorYellow
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        let tipView = EasyTipView(text: LanguageHelper.getString(key: "detail.base.baseTip"), preferences: preferences)
        tipView.show(forView: self.missionBaseInfoView.starImage_1, withinSuperview: self.navigationController?.view)
    
    }
    
    @objc private func bonusTip(){
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = kFont(size: 15)
        preferences.drawing.foregroundColor = kFontColorGray
        preferences.drawing.backgroundColor = kTintColorYellow
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        let tipView = EasyTipView(text: LanguageHelper.getString(key: "detail.base.bonusTip"), preferences: preferences)
        tipView.show(forView: self.missionBaseInfoView.starImage_2, withinSuperview: self.navigationController?.view)
        
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
            
            let model = Mapper<ZB_Task>().map(JSON: dic as! [String : Any])
  
          self.task = model
            
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
