//
//  RepairMissionDetailViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import MobileCoreServices
import SKPhotoBrowser
import MBProgressHUD
import Toast

class RepairMissionDetailViewController: MissionDetailBaseViewController,RepairPicUploadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CarryMissonImageAndFlieViewDelegate,ListRoomInfoViewDelegate,FeedbackViewDelegate{
    

    var cameraPicker: UIImagePickerController!
    var currentIndexpath: NSIndexPath?
    
    lazy var carryMissionInfoView: CarryMissionInfoView = {
        let view = CarryMissionInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 350)))
        return view
    }()
    
    lazy var carryImageView: CarryMissonImageAndFlieView = {
        let view = CarryMissonImageAndFlieView(frame: CGRect.init(x: 0, y: self.carryMissionInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 600)))
        view.delegate = self
        return view
    }()
    
    lazy var roomInfoView: ListRoomInfoView = {
        let view = ListRoomInfoView(frame: CGRect.init(x: 0, y: self.carryImageView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        view.delegate = self;
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        view.delegate = self
        return view
    }()
    
    lazy var infoTextView: RepairInfoTextView = {
        let view = RepairInfoTextView(frame: CGRect.init(x: 0, y: self.feedbackView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    lazy var uploadView: RepairPicUploadView = {
        let view:RepairPicUploadView = RepairPicUploadView(frame: CGRect.init(x: 0, y: self.infoTextView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: DEVICE_WIDTH/2-kResizedPoint(pt: 140), y: self.uploadView.bottom+kResizedPoint(pt: 30), width: 280, height: kResizedPoint(pt: 30))
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle("提交", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 键盘即将弹出
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // MARK: - 键盘即将回收
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    override func addSubViews() {
        super.addSubViews()
        self.scrollview.addSubview(self.carryMissionInfoView)
        self.scrollview.addSubview(self.carryImageView)
        self.scrollview.addSubview(self.roomInfoView)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.infoTextView)
        self.scrollview.addSubview(self.uploadView)
        self.scrollview.addSubview(self.submitButton)
        
        self.carryImageView.imageArray = ["https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg"]

        self.carryImageView.fileArray = ["https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg"]
        
//        self.feedbackView.congfigData()
        self.roomInfoView.roomArray = [] as [ZB_TaskProperty]
        self.uploadView.congfigData()
        self.uploadView.delegate = self
        
        self.carryImageView.height = self.carryImageView.viewHeight()
        self.roomInfoView.top = self.carryImageView.bottom + kResizedPoint(pt: 10)
        
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        
        self.feedbackView.height = self.feedbackView.viewHeight()
        self.infoTextView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
        
        self.infoTextView.height = self.infoTextView.viewHeight()
        self.uploadView.top = self.infoTextView.bottom
        
        self.uploadView.height = self.uploadView.viewHeight()
        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
 
   
        
    }
    
    override func configData() {
        
        let progress:String = self.task?.progress ?? "READY"
        self.currentProgress = ZB_ProgressType(rawValue: progress) ?? .ready
        
        self.feedbackView.isHidden = false
        self.infoTextView.isHidden = false
        self.uploadView.isHidden = false
        
        //基础
        self.roomInfoView.infoUploadButton.isHidden = true
        self.missionBaseInfoView.congfigDataWithTask(info: self.task!)
        self.carryMissionInfoView.congfigDataWithTask(info: self.task!)
        self.roomInfoView.roomArray = self.task?.taskInfo?.properties
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        
        self.carryImageView.imageArray = self.task?.taskInfo?.imgs
        self.carryImageView.fileArray = self.task?.taskInfo?.documents
        self.roomInfoView.roomArray = self.task?.taskInfo?.properties
        
        self.carryMissionInfoView.height = self.carryMissionInfoView.viewHeight()
        self.carryImageView.top = self.carryMissionInfoView.bottom
        self.carryImageView.height = self.carryImageView.viewHeight()
        self.roomInfoView.top = self.carryImageView.bottom + kResizedPoint(pt: 10)
        
        self.carryImageView.height = self.carryImageView.viewHeight()
        self.roomInfoView.top = self.carryImageView.bottom + kResizedPoint(pt: 10)
        
    
        //“信息上报”按钮
        if (self.currentProgress == .started || self.currentProgress == .ready){
            self.roomInfoView.infoUploadButton.isHidden = false
            self.roomInfoView.height = self.roomInfoView.viewHeight()
            
        }else{
            self.roomInfoView.infoUploadButton.isHidden = true
            self.roomInfoView.height = self.roomInfoView.viewHeight()-kResizedPoint(pt: 36)
        }
        
        //logs
        self.feedbackView.congfigDataWithTask(model: self.task!)
        self.feedbackView.height = self.feedbackView.viewHeight()
        let cout = self.task!.taskLogs?.count ?? 0
        if cout == 0 {
            self.feedbackView.clipsToBounds = true;
            self.feedbackView.top = self.roomInfoView.bottom
        }else{
            self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        }
        
        
        //
        self.infoTextView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
        self.infoTextView.height = self.infoTextView.viewHeight()
        
        //房间位置图片上传
        if (self.currentProgress == .started || self.currentProgress == .approve_failed) {
            self.uploadView.isHidden = false
            self.uploadView.top = self.infoTextView.bottom + kResizedPoint(pt: 10)
            self.uploadView.height = self.uploadView.viewHeight()
            
        }else{
            self.uploadView.isHidden = true
            self.uploadView.top = self.infoTextView.bottom
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
        
    }
    
    override func setupDataWithHomeModel() {
        self.feedbackView.isHidden = true
        self.infoTextView.isHidden = true
        self.uploadView.isHidden = true
        self.roomInfoView.infoUploadButton.isHidden = true

        self.missionBaseInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.carryImageView.imageArray = self.model?.imgs
        self.carryImageView.fileArray = self.model?.documents
//        self.roomInfoView.roomArray = self.model?.properties
        
        let timeInterv = timeToTimeStamp(time: (self.model?.startDate) ?? "")
        self.submitButton.setTitle(String(format: "%@(%@%@)", LanguageHelper.getString(key: "detail.actionName.qiangdan"),timeStampShortHourStr(timeStamp: timeInterv - 3600),LanguageHelper.getString(key:"detail.time.end")), for: .normal)
        
        self.carryImageView.height = self.carryImageView.viewHeight()
        self.roomInfoView.top = self.carryImageView.bottom + kResizedPoint(pt: 10)
        
        self.roomInfoView.height = self.roomInfoView.viewHeight()
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
                let dic = resultDic["data"]
                if dic == nil {
                    return
                }
                self.isTaked = true
                self.loadNewDataWithId(taskId: self.model?.id ?? 0)
                
            }) { (data, errMsg) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
                
                
            }
        }else{
            
            if self.currentProgress == .ready {
                //我已到达，开始任务
                let params = ["taskId":self.task?.id ?? 0 ] as [String : Any]
                
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
                let params = ["taskId":self.task?.id ?? 0 ] as [String : Any]
                
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
    
    //MARK: - RepairPicUploadViewDelegate
    func repairPicUploadView(_ cleanPicUploadView: RepairPicUploadView, didSelectedAtIndexPath indexPath: IndexPath) {
        currentIndexpath = indexPath as NSIndexPath
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let uploadVideoAction = UIAlertAction(title: "上传视频", style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera
            self.cameraPicker.mediaTypes = NSArray(objects: kUTTypeMovie) as! [String]
            self.cameraPicker.videoMaximumDuration = 10.0

  
            
            self.present(self.cameraPicker, animated: true, completion: nil)
        
        }
        
        let uploadAction = UIAlertAction(title: "上传图片", style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera
            
            self.present(self.cameraPicker, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(uploadVideoAction)
        alertController.addAction(uploadAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        self.cameraPicker = UIImagePickerController()
        self.cameraPicker.delegate = self
        self.cameraPicker.sourceType = .camera
        
        self.present(self.cameraPicker, animated: true, completion: nil)
    }
    
    //MARK: - 相机代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType:AnyObject? = info[UIImagePickerController.InfoKey.mediaType] as AnyObject
        
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
                    if let url = urlOfVideo {
                        print("视频地址: " + url.absoluteString!)
                        self.uploadView.addAndUploadVideo(url: url, atIndexPath: currentIndexpath!)
                        
                        self.uploadView.height = self.uploadView.viewHeight()
                        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
                        
                        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
                        
                    }
                }else{
                    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                    self.uploadView.addAndUploadImage(img: image, atIndexPath: currentIndexpath!)
                    
                    self.uploadView.height = self.uploadView.viewHeight()
                    self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
                    
                    self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
                    
                }
            }
        }

        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func keyBoardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyBoardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            //键盘的偏移量
           self.scrollview.contentOffset = CGPoint.init(x: 0, y: self.infoTextView.bottom-self.scrollview.height+deltaY)
        }
        
        if duration > 0 {
            let options = UIView.AnimationOptions(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))

            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)

        }else{
            animations()
        }
    }
    
    @objc private func keyBoardWillHide(notification: Notification) {
        let userInfo  = notification.userInfo!
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
             self.scrollview.contentOffset = CGPoint.init(x: 0, y: self.infoTextView.bottom-self.scrollview.height)
           
        }
        if duration > 0 {
            let options = UIView.AnimationOptions(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))

            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
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
        web.urlStr = "https://www.baidu.com"
        web.titleStr = "文件名"
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    
    //MARK: - ListRoomInfoViewDelegate
    func listRoomInfoViewDidTappedRoute(_ view: ListRoomInfoView, routeUrl routeUrlStr: String) {
        let web=WebViewController()
        web.hidesBottomBarWhenPushed = true
        web.urlStr = "https://www.baidu.com"
        web.titleStr = "文件名"
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    func listRoomInfoViewDidTappedPassword(_ view: ListRoomInfoView, password passws: [ZB_PwdInfo]) {
        let pass=PasswordViewController()
        pass.hidesBottomBarWhenPushed = true
        pass.passArr = passws
        self.navigationController?.pushViewController(pass, animated: true)
        
    }
    
    func listRoomInfoViewDidTappedUploadFeedback(_ view: ListRoomInfoView) {
        let feedback=QueFeedbackController()
        feedback.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(feedback, animated: true)
    }
    
    
    //MARK:- FeedbackViewDelegate
    func feedbackView(_ view: FeedbackView, lookoverImages images: Array<String>) {
        
        let imageArr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540296447089&di=8f6fa210da7498a6fefafe93179ef6be&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fcmpp%2F2016%2F11%2F04%2F17%2Fe4f9adfd-e00e-4a2f-9c93-e5014330281e_size31_w347_h500.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540296447089&di=8f6fa210da7498a6fefafe93179ef6be&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fcmpp%2F2016%2F11%2F04%2F17%2Fe4f9adfd-e00e-4a2f-9c93-e5014330281e_size31_w347_h500.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540296447089&di=8f6fa210da7498a6fefafe93179ef6be&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fcmpp%2F2016%2F11%2F04%2F17%2Fe4f9adfd-e00e-4a2f-9c93-e5014330281e_size31_w347_h500.jpg"]
        let count = imageArr.count
        
        var images = [SKPhoto]()
        for i in 0..<count{
            let photo = SKPhoto.photoWithImageURL(imageArr[i])
            photo.shouldCachePhotoURLImage = false
            images.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        self.present(browser, animated: true, completion: {})
        
    }
    
    func feedbackViewMoreAction(_ view: FeedbackView) {
        let feedback = FeedbackListViewController()
        feedback.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(feedback, animated: true)
        
    }
    
    
    
}
