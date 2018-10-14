//
//  RepairMissionDetailViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit

class RepairMissionDetailViewController: MissionDetailBaseViewController {
    
    
    lazy var roomInfoView: ListRoomInfoView = {
        let view = ListRoomInfoView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    lazy var feedbackView: FeedbackView = {
        let view = FeedbackView(frame: CGRect.init(x: 0, y: self.missionBaseInfoView.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 300)))
        return view
    }()
    
    
    //    lazy var takeButton: UIButton = {
    //        let btn = UIButton(type: UIButton.ButtonType.custom)
    //        btn.frame = CGRect.init(x: DEVICE_WIDTH/2-kResizedPoint(pt: 140), y: self.checkView.bottom+kResizedPoint(pt: 40), width: 280, height: kResizedPoint(pt: 30))
    //        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
    //        btn.backgroundColor = kTintColorYellow
    //        btn.setTitle("抢单(09-17 22:00截止)", for: .normal)
    //        btn.titleLabel?.font = kFont(size: 16)
    //        btn.addTarget(self, action: #selector(takeAction), for: UIControl.Event.touchUpInside)
    //        return btn
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.addSubview(self.roomInfoView)
        self.scrollview.addSubview(self.feedbackView)
        
        self.feedbackView.congfigData()
        self.roomInfoView.congfigData()
        
        self.roomInfoView.height = self.roomInfoView.viewHeight()
        self.feedbackView.top = self.roomInfoView.bottom + kResizedPoint(pt: 10)
        self.feedbackView.height = self.feedbackView.viewHeight()
        
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: self.missionBaseInfoView.height + kResizedPoint(pt: 10)+self.roomInfoView.height + kResizedPoint(pt: 10) + self.feedbackView.height )
        
    }
    
    
    //MARK: - actions
    @objc private func takeAction(){
        
    }
    
}
