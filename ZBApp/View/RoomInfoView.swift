//
//  RoomInfoView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.

import UIKit
import Masonry

protocol RoomInfoViewDelegate: class {
    func roomInfoViewDidTappedRoute(_ view: RoomInfoView, routeUrl routeUrlStr:String)
    func roomInfoViewDidTappedUploadFeedback(_ view: RoomInfoView)
    func roomInfoViewDidTappedPassword(_ view: RoomInfoView, password passws:[ZB_PwdInfo])
}
class RoomInfoView: UIView {
    weak var delegate: RoomInfoViewDelegate?
    
    var property: ZB_TaskProperty?//
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
//    private lazy var passwordLabel: UILabel = UILabel.cz_label(withText: "房间开锁密码:123456", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    lazy var passwordButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setImage(UIImage(named: "doorPass"), for: .normal)
        btn.setTitle(LanguageHelper.getString(key: "detail.roomInfo.password"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(passwordAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var nextCheckinNumLabel: UILabel = UILabel.cz_label(withText: "下次入住人数:2", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var maxCheckinNumLabel: UILabel = UILabel.cz_label(withText: "最大入住人数:3", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var nextCheckinDayLabel: UILabel = UILabel.cz_label(withText: "下次入住天数:3", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var remarkNameLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.remark"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)

    private lazy var roadRuteImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "file")
//        img.backgroundColor = kTintColorYellow
        return img
        
    }()
    
    private lazy var roadRuteLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.route"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var remarkLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.numberOfLines = 0
        lab.text = "多加一条被子多加一条被子多加一条被子多加一条被子多加一条被子"
        return lab
        
    }()
    
    private lazy var checkinNoteNameLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.checkinNote"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var checkinNoteLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.numberOfLines = 0
        lab.text = LanguageHelper.getString(key: "detail.roomInfo.checkinNoteValue")
        return lab
        
    }()
    
    lazy var infoUploadButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.blue
        btn.setTitle(LanguageHelper.getString(key: "detail.roomInfo.uploadInfo"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(infoUploadAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congfigSubViewHeight() {
        
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        let remarkH = UILabel.cz_labelHeight(withText: self.remarkLabel.text, size: size, font: self.remarkLabel.font)
        let noteH = UILabel.cz_labelHeight(withText: self.checkinNoteLabel.text, size: size, font: self.checkinNoteLabel.font)
        
  
        //20+52+25+17+10+17+10+17+10+remark+10+17+10+noteH+6
        let contentH = kResizedPoint(pt: 159+15+20+27) + noteH + remarkH
        
        self.contentView.mas_updateConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(contentH)
        }
    
    }
    
    //
    func congfigDataWithTaskInfo(info: ZB_TaskInfo){
        
        
        if info.properties?.count ?? 0 > 0 {
            self.property = info.properties![0]
            let taskProperty = info.properties?[0]
            self.nextCheckinNumLabel.text = String(format: "%@%d", LanguageHelper.getString(key: "detail.roomInfo.nextGuests"),taskProperty?.nextGuests ?? 0)
            self.maxCheckinNumLabel.text = String(format: "%@%d", LanguageHelper.getString(key: "detail.roomInfo.maxGuests"),taskProperty?.maxGuests ?? 0)
            self.nextCheckinDayLabel.text = String(format: "%@%d", LanguageHelper.getString(key: "detail.roomInfo.nextCheckInNights"),taskProperty?.nextCheckInNights ?? 0)
            
        }
        self.remarkLabel.text = info.remark
        self.infoUploadButton.isHidden = true
        
        self.congfigSubViewHeight()
    }
    
    
    
    //
    func congfigDataWithTask(info: ZB_Task){
        
        self.congfigSubViewHeight()
    }
    
    
    func viewHeight() -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        let remarkH = UILabel.cz_labelHeight(withText: self.remarkLabel.text, size: size, font: self.remarkLabel.font)
        let noteH = UILabel.cz_labelHeight(withText: self.checkinNoteLabel.text, size: size, font: self.checkinNoteLabel.font)
        
        //20+52+25+17+10+17+10+remark+10+17+10+noteH+6
        let contentH = kResizedPoint(pt: 159+15+20+27) + noteH + remarkH
        
        return (contentH+kResizedPoint(pt: 36))
    }
    
    
}

extension RoomInfoView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        
        self.contentView.addSubview(self.roadRuteImageView)
        self.contentView.addSubview(self.roadRuteLabel)
        
//        self.contentView.addSubview(self.passwordLabel)
        self.contentView.addSubview(self.passwordButton)
        self.contentView.addSubview(self.nextCheckinNumLabel)
        self.contentView.addSubview(self.maxCheckinNumLabel)
        self.contentView.addSubview(self.nextCheckinDayLabel)
        self.contentView.addSubview(self.remarkNameLabel)
        self.contentView.addSubview(self.remarkLabel)
        self.contentView.addSubview(self.checkinNoteNameLabel)
        self.contentView.addSubview(self.checkinNoteLabel)
        self.addSubview(self.infoUploadButton)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(routeAction))
        self.roadRuteImageView.isUserInteractionEnabled = true
        self.roadRuteImageView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(routeAction))
        self.roadRuteLabel.isUserInteractionEnabled = true
        self.roadRuteLabel.addGestureRecognizer(tap2)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        self.roadRuteImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 5))
            make.centerX.equalTo()(self.roadRuteLabel.mas_centerX)
            make.width.equalTo()(kResizedPoint(pt: 38))
            make.height.equalTo()(kResizedPoint(pt: 38))
        }
        
        self.roadRuteLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.roadRuteImageView.mas_bottom)?.offset()(kResizedPoint(pt: 2))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
//
//        self.passwordLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 20))
//            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
//            make.height.equalTo()(kResizedPoint(pt: 17))
//        }
        
        self.passwordButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 52))//32+3+17
        }
        
        self.passwordButton.layoutButton(with: MKButtonEdgeInsetsStyle.top, imageTitleSpace: kResizedPoint(pt: 3))
        
        self.nextCheckinNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.passwordButton.mas_bottom)?.offset()(kResizedPoint(pt: 25))
            make.left.equalTo()(self.passwordButton.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.maxCheckinNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.nextCheckinNumLabel.mas_centerY)
            make.left.equalTo()(self.nextCheckinNumLabel.mas_right)?.offset()(kResizedPoint(pt: 36))
            make.height.equalTo()(kResizedPoint(pt: 17))
            
        }
        
        self.nextCheckinDayLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nextCheckinNumLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.passwordButton.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.remarkNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nextCheckinDayLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.passwordButton.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.remarkLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.remarkNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.passwordButton.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.checkinNoteNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.remarkLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.checkinNoteLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.checkinNoteNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.passwordButton.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.infoUploadButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: 0))
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 26))
        }
        
    }
    
    //MARK: - actions
    @objc private func routeAction(){
        self.delegate?.roomInfoViewDidTappedRoute(self,routeUrl: self.property?.guideUrl ?? "")
        
    }
    
    @objc private func infoUploadAction(){
        self.delegate?.roomInfoViewDidTappedUploadFeedback(self)
    }
    
    @objc private func passwordAction(){
        self.delegate?.roomInfoViewDidTappedPassword(self, password: self.property?.pwdInfos ?? [])
    }
}

