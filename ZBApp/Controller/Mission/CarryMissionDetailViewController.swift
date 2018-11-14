//
//  CarryMissionDetailViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//搬场详情

import UIKit
import SKPhotoBrowser
import MBProgressHUD
import Toast

class CarryMissionDetailViewController: MissionDetailBaseViewController,CarryMissonImageAndFlieViewDelegate,FeedbackViewDelegate,CheckViewDelegate {

    lazy var carryMissionInfoView: CarryMissionInfoView = {
        let view = CarryMissionInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 350)))
        return view
    }()
    
    lazy var carryImageView: CarryMissonImageAndFlieView = {
        let view = CarryMissonImageAndFlieView(frame: CGRect.init(x: 0, y: self.carryMissionInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 600)))
        view.delegate = self
        return view
    }()
    
    lazy var infoUploadButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: DEVICE_WIDTH-kResizedPoint(pt: 90), y: self.carryImageView.bottom + kResizedPoint(pt: 10), width: kResizedPoint(pt: 90), height: kResizedPoint(pt: 26))
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.blue
        btn.setTitle(LanguageHelper.getString(key: "detail.roomInfo.uploadInfo"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(infoUploadAction), for: UIControl.Event.touchUpInside)
        return btn
    }()


    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.infoUploadButton.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 600)))
        view.delegate = self
        return view
    }()
    
    lazy var checkView: CheckView = {
        let view = CheckView(frame: CGRect.init(x: 0, y: self.feedbackView.bottom+kResizedPoint(pt: 20), width: DEVICE_WIDTH, height: kResizedPoint(pt: 100)))
        view.delegate = self
        return view
    }()
    
    lazy var takeButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: DEVICE_WIDTH/2-kResizedPoint(pt: 140), y: self.checkView.bottom+kResizedPoint(pt: 40), width: 280, height: kResizedPoint(pt: 30))
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle("抢单(09-17 22:00截止)", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.scrollview.addSubview(self.carryMissionInfoView)
        self.scrollview.addSubview(self.carryImageView)
        self.scrollview.addSubview(self.infoUploadButton)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.checkView)
        self.scrollview.addSubview(self.takeButton)
        
        self.carryImageView.imageArray = []
        self.carryImageView.fileArray = []
        self.feedbackView.congfigSubViewHeight()
        
//        self.checkView.congfigDataWithTask(model: ZB_Task(map:))
        
        self.carryMissionInfoView.height = self.carryMissionInfoView.viewHeight()
        self.carryImageView.top = self.carryMissionInfoView.bottom
        
        self.carryImageView.height = self.carryImageView.viewHeight()
        self.feedbackView.top = self.carryImageView.bottom+kResizedPoint(pt: 10)
        
        self.feedbackView.height = self.feedbackView.viewHeight()
        self.checkView.top = self.feedbackView.bottom+kResizedPoint(pt: 20)
        
        self.checkView.height = self.checkView.viewHeight()
        self.takeButton.top = self.checkView.bottom+kResizedPoint(pt: 40)
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.missionBaseInfoView.height + kResizedPoint(pt: 10)+self.carryMissionInfoView.height + self.carryImageView.height + kResizedPoint(pt: 10) + self.feedbackView.height + kResizedPoint(pt: 20) + self.checkView.height + kResizedPoint(pt: 40+30))
    }
    
    override func configData() {
        let progress:String = self.task?.progress ?? "READY"
        self.currentProgress = ZB_ProgressType(rawValue: progress) ?? .ready
        
        //基础
        self.missionBaseInfoView.congfigDataWithTask(info: self.task!)
        self.carryMissionInfoView.congfigDataWithTask(info: self.task!)
        self.carryImageView.imageArray = self.task?.taskInfo?.imgs
        self.carryImageView.fileArray = self.task?.taskInfo?.documents
        
        self.carryMissionInfoView.height = self.carryMissionInfoView.viewHeight()
        self.carryImageView.top = self.carryMissionInfoView.bottom

        self.carryImageView.height = self.carryImageView.viewHeight()
        
        //“信息上报”按钮
        if self.currentProgress == .started {
            self.infoUploadButton.isHidden = false
            self.infoUploadButton.top = self.carryImageView.bottom + kResizedPoint(pt: 10)
            self.infoUploadButton.height = kResizedPoint(pt: 26)
            
        }else{
            self.infoUploadButton.isHidden = true
            self.infoUploadButton.top = self.carryImageView.bottom
            self.infoUploadButton.height = 0
        }
        
        //logs
        self.feedbackView.congfigDataWithTask(model: self.task!)
        self.feedbackView.height = self.feedbackView.viewHeight()
        let cout = self.task!.taskLogs?.count ?? 0
        if cout == 0 {
            self.feedbackView.clipsToBounds = true;
            self.feedbackView.top = self.infoUploadButton.bottom
        }else{
            self.feedbackView.top = self.infoUploadButton.bottom + kResizedPoint(pt: 10)
        }
        
        //验收结果
        if self.currentProgress == .finished {
            self.checkView.isHidden = false
            self.checkView.congfigDataWithTask(model: self.task!)
            self.checkView.top = self.feedbackView.bottom+kResizedPoint(pt: 20)
            self.checkView.height = self.checkView.viewHeight()
            
        }else{
            self.checkView.isHidden = true
            self.checkView.top = self.feedbackView.bottom
            self.checkView.height = 0;
            
        }
        
        //提交按钮
        if self.currentProgress == .ready{
            self.takeButton.isHidden = false
            self.takeButton.setTitle(LanguageHelper.getString(key: "detail.submitBtnTit.transfer"), for: .normal)
            self.takeButton.top = self.checkView.bottom+kResizedPoint(pt: 40)
            self.takeButton.height = kResizedFont(ft: 30)
            
        }else{
            self.takeButton.isHidden = true
            self.takeButton.top = self.checkView.bottom
            self.takeButton.height = 0
        }
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.takeButton.bottom + kResizedPoint(pt: 40))
        
      
        
    }
    
    override func setupDataWithHomeModel() {
        self.infoUploadButton.isHidden = true
        self.feedbackView.isHidden = true
        self.checkView.isHidden = true
        self.missionBaseInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.carryMissionInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.carryImageView.imageArray = self.model?.imgs
        self.carryImageView.fileArray = self.model?.documents
        
        let timeInterv = timeToTimeStamp(time: (self.model?.startDate) ?? "")
      
        self.takeButton.setTitle(String(format: "%@(%@%@)", LanguageHelper.getString(key: "detail.actionName.qiangdan"),timeStampShortHourStr(timeStamp: timeInterv - 3600),LanguageHelper.getString(key:"detail.time.end")), for: .normal)
        
        self.carryMissionInfoView.height = self.carryMissionInfoView.viewHeight()
        self.carryImageView.top = self.carryMissionInfoView.bottom
        
        self.carryImageView.height = self.carryImageView.viewHeight()
        
        self.takeButton.top = self.carryImageView.bottom + kResizedPoint(pt: 30)

        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.takeButton.bottom + kResizedPoint(pt: 40))
        
    }
    
    
    //MARK: - actions
    @objc private func infoUploadAction(){
        let feedback=QueFeedbackController()
        feedback.hidesBottomBarWhenPushed = true
        if self.isTaked {
            feedback.mID = self.task?.id ?? 0
            feedback.type = self.task?.taskInfo?.type
        }else{
            feedback.mID = self.model?.id ?? 0
            feedback.type = self.model?.type
        }
        self.navigationController?.pushViewController(feedback, animated: true)
    }
    
    @objc private func takeAction(){
        if self.isTaked == false {
            //抢单
            let params = ["taskId":self.model?.id ?? 0] as [String : Any]
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            NetWorkManager.shared.loadRequest(method: .post, url: ReceiveTaskUrl, parameters: params as [String : Any], success: { (data) in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                let resultDic = data as! Dictionary<String,AnyObject>
                let executorId = resultDic["data"] as! Int64
                if executorId == nil {
                    return
                }
                self.isTaked = true
                self.loadNewDataWithId(taskId: executorId ?? 0)
                
            }) { (data, errMsg) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
                
            }
        }else{
            
            if self.currentProgress == .ready {
                
                let reasonText = TransferReasonView(frame: CGRect.init())
                reasonText.showInView(suView: self.view) { (reason, isSureAction) in
                    if isSureAction{
                        print("sure:\(String(describing: reason))")
                        if reason == "" {
                            self.view.makeToast("reason is nil", duration: 2, position: CSToastPositionCenter)
                            return
                        }
                        
                        
                        //申请转单
                        let params = ["id":self.task?.id ?? 0 ,"reason":reason ?? ""] as [String : Any]
                        
                        MBProgressHUD.showAdded(to: self.view, animated: true)
                        NetWorkManager.shared.loadRequest(method: .post, url: TransferTaskUrl, parameters: params as [String : Any], success: { (data) in
                            MBProgressHUD.hide(for: self.view, animated: true)
                            
                            let resultDic = data as! Dictionary<String,AnyObject>
                            let dic = resultDic["data"]
                            if dic == nil {
                                return
                            }
                            self.loadNewDataWithId(taskId: self.task?.id ?? 0)
                            
                        }) { (data, errMsg) in
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
                            
                        }
                        
                    }else{
                        print("cancel")
                    }
                }
                
            }
            
        }
        
    }
    

    // MARK: - CarryMissonImageAndFlieViewDelegate
    func carryMissonImageAndFlieView(_ view: CarryMissonImageAndFlieView, didSelectedImageAtIndex index: NSInteger) {
        let count = self.carryImageView.imageArray!.count
        
        var images = [SKPhoto]()
        for i in 0..<count{
            let photo = SKPhoto.photoWithImageURL(self.carryImageView.imageArray![i])
            photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
            images.append(photo)
        }
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(index)
        self.present(browser, animated: true, completion: {})
        
       
        
    }
    
    func carryMissonImageAndFlieView(_ view: CarryMissonImageAndFlieView, didSelectedFileAtIndex index: NSInteger) {
        let web=WebViewController()
        web.hidesBottomBarWhenPushed = true
        let urlStr = view.fileArray?[index]
        web.urlStr = urlStr
        web.titleStr = LanguageHelper.getString(key: "detail.doument.title")
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    //MARK:- checkViewDelegate
    func checkView(_ view: CheckView, didSelectedImageAtIndex index: NSInteger) {
        let count = self.checkView.imageArray!.count
        
        var images = [SKPhoto]()
        for i in 0..<count{
            let photo = SKPhoto.photoWithImageURL(self.checkView.imageArray![i])
            photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
            images.append(photo)
        }
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(index)
        self.present(browser, animated: true, completion: {})
        
    }
    
    //MARK:- FeedbackViewDelegate
    func feedbackView(_ view: FeedbackView, lookoverImages images: Array<String>) {
        
        let count = images.count
        
        var phoImages = [SKPhoto]()
        for i in 0..<count{
            let photo = SKPhoto.photoWithImageURL(images[i])
            photo.shouldCachePhotoURLImage = false
            phoImages.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: phoImages)
        browser.initializePageIndex(0)
        self.present(browser, animated: true, completion: {})
        
    }
    
    func feedbackViewMoreAction(_ view: FeedbackView) {
        let feedback = FeedbackListViewController()
        feedback.taskLogs = self.task?.taskLogs
        
        feedback.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(feedback, animated: true)
        
    }
    
    

}
