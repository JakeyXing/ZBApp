//
//  CleanMissionDetailViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//清扫详情

import UIKit
import JXPhotoBrowser

class CleanMissionDetailViewController: MissionDetailBaseViewController,CleanPicUploadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var cameraPicker: UIImagePickerController!
    var currentImageCell: CleanImageCell?
    
    
    lazy var roomInfoView: RoomInfoView = {
        let view = RoomInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
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
        btn.setTitle("提交", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.addSubview(self.roomInfoView)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.uploadView)
        self.scrollview.addSubview(self.submitButton)
        
        self.uploadView.delegate = self
        
        self.feedbackView.congfigData()
        self.roomInfoView.congfigData()
        self.uploadView.congfigData()

        self.roomInfoView.height = self.roomInfoView.viewHeight()
        self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        
        self.feedbackView.height = self.feedbackView.viewHeight()
        self.uploadView.top = self.feedbackView.bottom + kResizedPoint(pt: 10)
        
        self.uploadView.height = self.uploadView.viewHeight()
        self.submitButton.top = self.uploadView.bottom + kResizedPoint(pt: 30)

//        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.missionBaseInfoView.height + kResizedPoint(pt: 10)+self.roomInfoView.height + kResizedPoint(pt: 10) + self.feedbackView.height + kResizedPoint(pt: 10) + self.uploadView.height )
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.submitButton.bottom + kResizedPoint(pt: 20))
        
    }
    
    
    //MARK: - actions
    @objc private func takeAction(){
        
    }
    
    //MARK: - CleanPicUploadViewDelegate
    
    func cleanPicUploadView(_ cleanPicUploadView: CleanPicUploadView,didSelectedCell cell: CleanImageCell,atIndexPath indexPath: IndexPath) {
        currentImageCell = cell
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let lookImageAction = UIAlertAction(title: "查看大图", style:  .default) { (action) in
            if cell.oriImage == nil{
                return
            }

            PhotoBrowser.show(localImages: [cell.imageView.image!], originPageIndex: 0)
        }
        
        let uploadAction = UIAlertAction(title: "上传图片", style:  .default) { (action) in
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.delegate = self
            self.cameraPicker.sourceType = .camera

            self.present(self.cameraPicker, animated: true, completion: nil)

        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
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

}

