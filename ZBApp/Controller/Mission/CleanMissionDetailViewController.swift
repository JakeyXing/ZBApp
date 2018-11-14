//
//  CleanMissionDetailViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//清扫详情

import UIKit
import SKPhotoBrowser
import MBProgressHUD
import Toast
import ObjectMapper

class CleanMissionDetailViewController: MissionDetailBaseViewController,CleanPicUploadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RoomInfoViewDelegate,FeedbackViewDelegate {
   
    var cameraPicker: UIImagePickerController!
    var currentImageCell: CleanImageCell?
    
    
    lazy var roomInfoView: RoomInfoView = {
        let view = RoomInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        view.delegate = self
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.roomInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        view.delegate = self
        return view
    }()
    
    lazy var uploadView: CleanPicUploadView = {
        let view:CleanPicUploadView = CleanPicUploadView(frame: CGRect.init(x: 0, y: self.feedbackView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    

    lazy var submitButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: DEVICE_WIDTH/2-kResizedPoint(pt: 140), y: self.uploadView.bottom+kResizedPoint(pt: 30), width: 280, height: kResizedPoint(pt: 30))
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "apply.nav.submit"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.scrollview.addSubview(self.roomInfoView)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.uploadView)
        self.scrollview.addSubview(self.submitButton)
        
        self.uploadView.delegate = self
        
        self.feedbackView.congfigSubViewHeight()
        self.roomInfoView.congfigSubViewHeight()
//        self.uploadView.congfigData()
        
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        
        self.feedbackView.height = self.feedbackView.viewHeight()
        self.uploadView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
        
        self.uploadView.height = self.uploadView.viewHeight()
        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
      
    }
    
    override func configData() {
        let progress:String = self.task?.progress ?? "READY"
        self.currentProgress = ZB_ProgressType(rawValue: progress) ?? .ready
        
        //基础
        self.missionBaseInfoView.congfigDataWithTask(info: self.task!)
        self.roomInfoView.congfigDataWithTaskInfo(info: (self.task?.taskInfo)!)
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        
        
        //“信息上报”按钮
        if (self.currentProgress == .started || self.currentProgress == .ready){
            self.roomInfoView.infoUploadButton.isHidden = false
            
        }else{
            self.roomInfoView.infoUploadButton.isHidden = true
            self.roomInfoView.height = self.roomInfoView.viewHeight()-kResizedPoint(pt: 36)
        }
        
        //logs
        self.feedbackView.congfigDataWithTask(model: self.task!)
        self.feedbackView.height = self.feedbackView.viewHeight()
        let cout = self.task?.taskLogs?.count ?? 0
        if cout == 0 {
            self.feedbackView.clipsToBounds = true;
            self.feedbackView.top = self.roomInfoView.bottom
        }else{
            self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        }
        
        //房间位置图片上传
        if (self.currentProgress == .started || self.currentProgress == .approve_failed) {
            self.uploadView.congfigDataWithTask(model: self.task!)
            self.uploadView.isHidden = false
            self.uploadView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
            self.uploadView.height = self.uploadView.viewHeight()
          
        }else{
            self.uploadView.isHidden = true
            self.uploadView.top = self.feedbackView.bottom
            self.uploadView.height = 0
           
        
        }
        
        //提交按钮
        if self.currentProgress == .ready || self.currentProgress == .started{
            self.submitButton.isHidden = false
            self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
            self.submitButton.height = kResizedFont(ft: 30)
            
            if self.currentProgress == .ready {
                self.submitButton.setTitle(LanguageHelper.getString(key: "detail.submitBtnTit.startMission"), for: .normal)
                
            }else{
                self.submitButton.setTitle(LanguageHelper.getString(key: "detail.submitBtnTit.approveCheck"), for: .normal)
                
            }
            
        }else{
            self.submitButton.isHidden = true
            self.submitButton.top = self.uploadView.bottom
            self.submitButton.height = 0
        }
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 40))
        
        if "FINISHED_NOSHOW,FINISHED,ABANDON_TRANSFER,ABANDON_OPERATE,CANCELED".contains(progress) {
            roomInfoView.hidePass()
        }
    }
    
    override func setupDataWithHomeModel() {
        self.feedbackView.isHidden = true
        self.uploadView.isHidden = true
        
        self.missionBaseInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.roomInfoView.congfigDataWithTaskInfo(info: self.model!)
     
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        let timeInterv = timeToTimeStamp(time: (self.model?.startDate) ?? "")

        self.submitButton.setTitle(String(format: "%@(%@%@)", LanguageHelper.getString(key: "detail.actionName.qiangdan"),timeStampShortHourStr(timeStamp: timeInterv - 3600),LanguageHelper.getString(key:"detail.time.end")), for: .normal)

        
        self.submitButton.top = self.roomInfoView.bottom + kResizedPoint(pt: 30)
        
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
        
    }
    
    
    //MARK: - actions
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
                //我已到达，开始任务
                let params = ["id":self.task?.id ?? 0 ] as [String : Any]
                
                MBProgressHUD.showAdded(to: self.view, animated: true)
                NetWorkManager.shared.loadRequest(method: .post, url: StartTaskUrl, parameters: params as [String : Any], success: { (data) in
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
                
            }else if(self.currentProgress == .started){
                //提交审核
                let cout = self.uploadView.roomWithImagesArrayForUpload.count
                
                var cleanPhotos = [[String:Any]]()
                for i in 0..<cout{
                    let item = self.uploadView.roomWithImagesArrayForUpload[i]
                    let photoCount = item.photos!.count
                    
                    for index in 0..<photoCount{
                        let photo = item.photos![index]
                        photo.location = item.location
                        if (photo.url == nil || photo.url == ""){
                            self.view.makeToast(LanguageHelper.getString(key: "detail.cleanPic.uploadPicNumTip"), duration: 2.5, position: CSToastPositionCenter)
                            return;
                        }
                        let dic:[String: Any] = photo.toJSON()
                        cleanPhotos.append(dic)
                    }
                    
                }
                
                let params = ["id":self.task?.id ?? 0,"cleanPhotos":cleanPhotos ] as [String : Any]
                
                MBProgressHUD.showAdded(to: self.view, animated: true)
                NetWorkManager.shared.loadRequest(method: .post, url: ApproveTaskUrl, parameters: params as [String : Any], success: { (data) in
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
                
            }
            
        }
        
    }
    
    //MARK: - CleanPicUploadViewDelegate
    
    func cleanPicUploadView(_ cleanPicUploadView: CleanPicUploadView,didSelectedCell cell: CleanImageCell,atIndexPath indexPath: IndexPath) {
        currentImageCell = cell
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let lookImageAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.lookPImage"), style:  .default) { (action) in
            if cell.oriImage == nil{
                return
            }

            var images = [SKPhoto]()
            let photo = SKPhoto.photoWithImage(cell.oriImage!)// add some UIImage
            images.append(photo)
            
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            self.present(browser, animated: true, completion: {})
        }
        
        let uploadAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.image"), style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera

            self.present(self.cameraPicker, animated: true, completion: nil)

        }
        
        let cancelAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.cancel"), style: .cancel, handler: nil)
        
        alertController.addAction(lookImageAction)
        alertController.addAction(uploadAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - 相机代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        currentImageCell?.uploadImage(img: image)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- RoomInfoViewDelegate
    func roomInfoViewDidTappedRoute(_ view: RoomInfoView, routeUrl routeUrlStr: String) {
        let web=WebViewController()
        web.hidesBottomBarWhenPushed = true
        web.urlStr = routeUrlStr
        web.titleStr = LanguageHelper.getString(key: "detail.route.pageTitle")
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    func roomInfoViewDidTappedUploadFeedback(_ view: RoomInfoView) {
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
    
    func roomInfoViewDidTappedPassword(_ view: RoomInfoView, password passws: [ZB_PwdInfo]) {
        
        let pass=PasswordViewController()
        pass.hidesBottomBarWhenPushed = true
        pass.passArr = passws
        self.navigationController?.pushViewController(pass, animated: true)
        
    }
    
    //MARK:- FeedbackViewDelegate
    func feedbackView(_ view: FeedbackView, lookoverImages images: Array<String>) {
        
        let count = images.count
        
        var photoImages = [SKPhoto]()
        for i in 0..<count{
            let photo = SKPhoto.photoWithImageURL(images[i])
            photo.shouldCachePhotoURLImage = false
            photoImages.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: photoImages)
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

