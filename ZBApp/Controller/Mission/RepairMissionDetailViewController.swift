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
        btn.frame = CGRect.init(x: DEVICE_WIDTH/2-kResizedPoint(pt: 90), y: self.uploadView.bottom+kResizedPoint(pt: 30), width: 280, height: kResizedPoint(pt: 30))
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "apply.nav.submit"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //申请转单
    lazy var transferButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect.init(x: kResizedPoint(pt: 20), y: self.submitButton.top, width: 80, height: kResizedPoint(pt: 30))
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
//        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "detail.submitBtnTit.transfer"), for: .normal)
        btn.titleLabel?.font = kFont(size: 14)
        btn.addTarget(self, action: #selector(transferAction), for: UIControl.Event.touchUpInside)
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
        self.scrollview.addSubview(self.transferButton)
        
        self.carryImageView.imageArray = []

        self.carryImageView.fileArray = []
        
//        self.feedbackView.congfigData()
        self.roomInfoView.roomArray = [] as [ZB_TaskProperty]
//        self.uploadView.congfigData()
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
        
        
        //结果提交+图片上传
        if (self.currentProgress == .started) {
            //todo
            
            //
            self.infoTextView.isHidden = false
            self.infoTextView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
            self.infoTextView.height = self.infoTextView.viewHeight()
            
            self.uploadView.isHidden = false
            self.uploadView.top = self.infoTextView.bottom + kResizedPoint(pt: 10)
            self.uploadView.congfigDataWithTask(info: self.task!)
            self.uploadView.height = self.uploadView.viewHeight()
            
        }else{
            //
            self.infoTextView.isHidden = true
            self.infoTextView.top = self.feedbackView.bottom
            self.infoTextView.height = 0
            
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
        
        //转单按钮
        if self.currentProgress == .ready{
            self.transferButton.isHidden = false
            self.transferButton.top = self.submitButton.top
        }else{
            self.transferButton.isHidden = true
        }
        
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 40))
        
    }
    
    override func setupDataWithHomeModel() {
        self.feedbackView.isHidden = true
        self.infoTextView.isHidden = true
        self.uploadView.isHidden = true
        self.roomInfoView.infoUploadButton.isHidden = true
        self.transferButton.isHidden = true


        self.missionBaseInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.carryMissionInfoView.congfigDataWithTaskInfo(info: self.model!)
        self.carryImageView.imageArray = self.model?.imgs
        self.carryImageView.fileArray = self.model?.documents
        self.roomInfoView.roomArray = self.model?.properties
        
        let timeInterv = timeToTimeStamp(time: (self.model?.startDate) ?? "")
        self.submitButton.setTitle(String(format: "%@(%@%@)", LanguageHelper.getString(key: "detail.actionName.qiangdan"),timeStampShortHourStr(timeStamp: timeInterv - 3600),LanguageHelper.getString(key:"detail.time.end")), for: .normal)
        
        self.carryMissionInfoView.height = self.carryMissionInfoView.viewHeight()
        self.carryImageView.top = self.carryMissionInfoView.bottom
        
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
                let params = ["id":self.task?.id ?? 0 ] as [String : Any]
                
                MBProgressHUD.showAdded(to: self.view, animated: true)
                NetWorkManager.shared.loadRequest(method: .post, url: StartTaskUrl, parameters: params as [String : Any], success: { (data) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    let resultDic = data as! Dictionary<String,AnyObject>
                    let executorId = resultDic["data"] as! Int64
                    self.loadNewDataWithId(taskId: executorId)
                    
                }) { (data, errMsg) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
                    
                }
                
            }else if(self.currentProgress == .started){
                //提交审核
                let cout = self.uploadView.roomWithImagesArray?.count ?? 0
                
                var maPhotos = [[String:Any]]()
                
                for i in 0..<cout{
                    let item = self.uploadView.roomWithImagesArray![i]
                    let photoCount = item.photos!.count
                    
                    for index in 0..<photoCount{
                        let photo = item.photos![index]
                        if (photo.url == nil || photo.url == ""){
                            
                            return;
                        }
                        let dic:[String: Any] = photo.toJSON()
                        maPhotos.append(dic)
                    }
                    
                }
                

                let params = ["id":self.task?.id ?? 0 ,"maintainPhotos":maPhotos] as [String : Any]
                
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
    
    @objc private func transferAction(){
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
    
    
    //MARK: - RepairPicUploadViewDelegate
    func repairPicUploadViewDidUplaodSuccess(_ view: RepairPicUploadView) {
        self.uploadView.height = self.uploadView.viewHeight()
        
        //提交按钮
        if self.currentProgress == .ready || self.currentProgress == .started{
            self.submitButton.isHidden = false
            self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
            self.submitButton.height = kResizedFont(ft: 30)
            
        }else{
            self.submitButton.isHidden = true
            self.submitButton.top = self.uploadView.bottom
            self.submitButton.height = 0
        }
        
        //转单按钮
        if self.currentProgress == .ready{
            self.transferButton.isHidden = false
            self.transferButton.top = self.submitButton.top
        }else{
            self.transferButton.isHidden = true
        }
        
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 40))
        
    }
    
    func repairPicUploadView(_ cleanPicUploadView: RepairPicUploadView, didSelectedAtIndexPath indexPath: IndexPath) {
        currentIndexpath = indexPath as NSIndexPath
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let uploadVideoAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.video"), style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera
            self.cameraPicker.mediaTypes = NSArray(objects: kUTTypeMovie) as! [String]
            self.cameraPicker.videoMaximumDuration = 10.0

            self.present(self.cameraPicker, animated: true, completion: nil)
        
        }
        
        let uploadAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.image"), style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera
            
            self.present(self.cameraPicker, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: LanguageHelper.getString(key: "detail.repairUploadAction.cancel"), style: .cancel, handler: nil)
        
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
            photo.shouldCachePhotoURLImage = false
            images.append(photo)
        }
        
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
    
    
    //MARK: - ListRoomInfoViewDelegate
    func listRoomInfoViewDidTappedRoute(_ view: ListRoomInfoView, routeUrl routeUrlStr: String) {
        let web=WebViewController()
        web.hidesBottomBarWhenPushed = true
        web.urlStr = routeUrlStr
        web.titleStr = LanguageHelper.getString(key: "detail.route.pageTitle")
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
        if self.isTaked {
            feedback.mID = self.task?.id ?? 0
            feedback.type = self.task?.taskInfo?.type
        }else{
            feedback.mID = self.model?.id ?? 0
            feedback.type = self.model?.type
        }
        self.navigationController?.pushViewController(feedback, animated: true)
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
