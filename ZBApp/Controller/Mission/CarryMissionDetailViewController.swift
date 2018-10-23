//
//  CarryMissionDetailViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//搬场详情

import UIKit
import SKPhotoBrowser
class CarryMissionDetailViewController: MissionDetailBaseViewController,CarryMissonImageAndFlieViewDelegate,FeedbackViewDelegate {

    lazy var carryMissionInfoView: CarryMissionInfoView = {
        let view = CarryMissionInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 350)))
        return view
    }()
    
    lazy var carryImageView: CarryMissonImageAndFlieView = {
        let view = CarryMissonImageAndFlieView(frame: CGRect.init(x: 0, y: self.carryMissionInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 600)))
        view.delegate = self
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.carryImageView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 600)))
        view.delegate = self
        return view
    }()
    
    lazy var checkView: CheckView = {
        let view = CheckView(frame: CGRect.init(x: 0, y: self.feedbackView.bottom+kResizedPoint(pt: 20), width: DEVICE_WIDTH, height: kResizedPoint(pt: 100)))
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
        self.scrollview.addSubview(self.carryMissionInfoView)
        self.scrollview.addSubview(self.carryImageView)
        self.scrollview.addSubview(self.feedbackView)
        self.scrollview.addSubview(self.checkView)
        self.scrollview.addSubview(self.takeButton)
        
        self.carryImageView.imageArray = ["https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg"]
        
        self.carryImageView.fileArray = ["https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg","https://video.parentschat.com/pic_R3_720.jpg"]
        self.feedbackView.congfigData()
        
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
        
    }
    
    
    //MARK: - actions
    @objc private func takeAction(){
        
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
