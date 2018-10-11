//
//  MissionTypeTopBar.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/10.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class MissionTypeTopBar: UIView {
    //MARK: - 控件
    private lazy var typeTitleButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorBlack, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.setTitle("摆场", for:  UIControl.State.normal)
        btn.addTarget(self, action: #selector(typeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var iconImageView: UIImageView = UIImageView(image: UIImage(named:"school_icon01"))
    
    private lazy var dateChooseButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.setTitle("选择日期", for:  UIControl.State.normal)
        btn.addTarget(self, action: #selector(dateAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var typeListView: JHListChooseView = {
        let view = JHListChooseView(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT))
        view.delegate = self
       
        return view
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: 44))
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - actions
    @objc private func typeAction(){
        self.typeListView.typeArray = ["qqqq","eeee"]
        UIApplication.shared.keyWindow?.addSubview(self.typeListView)
        
    }
    
    @objc private func dateAction(){
        let calendarBg = CalendarBgView(frame: CGRect.init())
        calendarBg.delegate = self;
        UIApplication.shared.keyWindow?.addSubview(calendarBg)
    }
    
    
}

extension MissionTypeTopBar: JHListChooseViewDelegate,CalendarBgViewDelegate{
    func listChooseViewDidClosed(_ listChooseView: JHListChooseView) {
        self.typeListView.removeFromSuperview()
    }
    
    func listChooseView(_ listChooseView: JHListChooseView, didSelectedIndex index: NSInteger) {
        self.typeListView.removeFromSuperview()
    }
    
    func calendarDidChoosedDate(choosedDate: Date) {
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: choosedDate))
        
        self.dateChooseButton.setTitle(formatter.string(from: choosedDate), for: .normal)
    }
    
}

extension MissionTypeTopBar{
    
    //MARK: - private methods
    
    func initView(){
        self.addSubview(self.typeTitleButton)
        self.addSubview(self.iconImageView)
        self.addSubview(self.dateChooseButton)
    
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        self.typeTitleButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 50))
            make.height.equalTo()(30)
        }
        
        self.iconImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self.typeTitleButton.mas_right)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 9))
            make.height.equalTo()(kResizedPoint(pt: 6))
        }
        
        self.dateChooseButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self.iconImageView.mas_right)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        
    }
    
}
