//
//  MissionTypeTopBar.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/10.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

protocol MissionTypeTopBarDelegate: class {
    func missionTypeTopBar(_ topBar: MissionTypeTopBar,didSelectedDate date: Date)
    func missionTypeTopBarDidCleanDate(_ topBar: MissionTypeTopBar)
}

class MissionTypeTopBar: UIView {
    
    //MARK: - delegate
    weak var delegate: MissionTypeTopBarDelegate?
    //MARK: - 控件
    lazy var taskTypeDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = LanguageHelper.getString(key: "home.dropDwon.all")
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["home.dropDwon.all","home.dropDwon.launch","home.dropDwon.dismantle","home.dropDwon.maintain","home.dropDwon.clean"]
        view.extraTop = statusBarHeight
        return view
    }()
    
    
    private lazy var dateChooseButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.setTitle(LanguageHelper.getString(key: "home.navi.time"), for:  UIControl.State.normal)
        btn.addTarget(self, action: #selector(dateAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var cleanDateButton: UIButton = {
        let back = UIButton(type: UIButton.ButtonType.custom)
        back.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        back.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return back
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
    @objc private func dateAction(){
        let calendarBg = CalendarBgView(frame: CGRect.init())
        calendarBg.delegate = self;
        UIApplication.shared.keyWindow?.addSubview(calendarBg)
    }
    @objc private func closeAction(){
        self.cleanDateButton.isHidden = true
        self.dateChooseButton.setTitle(LanguageHelper.getString(key: "home.navi.time"), for: .normal)
        self.delegate?.missionTypeTopBarDidCleanDate(self)
        
    }
    
    
    
}

extension MissionTypeTopBar: CalendarBgViewDelegate{
    func calendarDidChoosedDate(choosedDate: Date) {
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: choosedDate))
        self.cleanDateButton.isHidden = false
        
        self.dateChooseButton.setTitle(formatter.string(from: choosedDate), for: .normal)
        self.delegate?.missionTypeTopBar(self, didSelectedDate: choosedDate)
    }
    
}

extension MissionTypeTopBar{
    
    //MARK: - private methods
    
    func initView(){
        self.addSubview(self.taskTypeDropdownView)
        self.addSubview(self.dateChooseButton)
        self.addSubview(self.cleanDateButton)
        self.cleanDateButton.isHidden = true
    
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        self.taskTypeDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 80))
            make.height.equalTo()(28)
        }
        
        
        self.dateChooseButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self.taskTypeDropdownView.mas_right)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.cleanDateButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self.dateChooseButton.mas_right)?.offset()(kResizedPoint(pt: 2))
            make.width.equalTo()(kResizedPoint(pt: 35))
            make.height.equalTo()(kResizedPoint(pt: 32))
        }
        
        
    }
    
}
