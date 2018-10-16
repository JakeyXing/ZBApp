//
//  RepairMissionDetailViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import MobileCoreServices

class RepairMissionDetailViewController: MissionDetailBaseViewController,RepairPicUploadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var cameraPicker: UIImagePickerController!
    var currentIndexpath: NSIndexPath?
    
    lazy var roomInfoView: ListRoomInfoView = {
        let view = ListRoomInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
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
        self.scrollview.addSubview(self.roomInfoView)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.infoTextView)
        self.scrollview.addSubview(self.uploadView)
        self.scrollview.addSubview(self.submitButton)
        
        self.feedbackView.congfigData()
        self.roomInfoView.congfigData()
        self.uploadView.congfigData()
        self.uploadView.delegate = self
        
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        
        self.feedbackView.height = self.feedbackView.viewHeight()
        self.infoTextView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
        
        self.infoTextView.height = self.infoTextView.viewHeight()
        self.uploadView.top = self.infoTextView.bottom
        
        self.uploadView.height = self.uploadView.viewHeight()
        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
        
        
        // MARK: - 键盘即将弹出
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // MARK: - 键盘即将回收
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
    }
    
    
    //MARK: - actions
    @objc private func takeAction(){
        
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
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.uploadView.addAndUploadImage(img: image, atIndexPath: currentIndexpath!)
        
        self.uploadView.height = self.uploadView.viewHeight()
        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
        
        
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
    
}
