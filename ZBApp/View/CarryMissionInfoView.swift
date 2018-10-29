//
//  CarryMissionInfoView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.

//搬场

import UIKit
import Masonry

class CarryMissionInfoView: UIView {
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220 
        return content
    }()
    
    lazy var missionTitleNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kMediumFont(size: 15)
        lab.text = LanguageHelper.getString(key: "detail.statusInfo.title")
        return lab
        
    }()
    
    private lazy var missionTitleLabel: UILabel = UILabel.cz_label(withText: "办公室搬场", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var missionDescribNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kMediumFont(size: 15)
        lab.text = LanguageHelper.getString(key: "detail.statusInfo.describ")
        return lab
        
    }()
    
    lazy var missionDescribLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = "海外网10月12日电当地时间10月12日，2018年“新学院奖”在瑞典斯德哥尔摩公共图书馆揭晓，玛丽斯·孔戴(Maryse Condé)获得此奖项"
        lab.numberOfLines = 0
        return lab
        
    }()
    
    
    lazy var missionRemarkNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kMediumFont(size: 15)
        lab.text = LanguageHelper.getString(key: "detail.statusInfo.remark")
        return lab
        
    }()
    
    lazy var missionRemarkLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = "海外网10月12日电当地时间10月12日，2018年“新学院奖”在瑞典斯德哥尔摩公共图书馆揭晓，玛丽斯·孔戴(Maryse Condé)获得此奖项"
        lab.numberOfLines = 0
        return lab
        
    }()

    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - actions
    
    @objc private func starImageTapped(){
        //        self.delegate?.rightAction()
    }
    
    //
    func congfigDataWithTaskInfo(info: ZB_TaskInfo){
        
        self.missionTitleLabel.text = info.title
        self.missionDescribLabel.text = info.desc
        self.missionRemarkLabel.text = info.remark
    }
    
    //
    func congfigDataWithTask(info: ZB_Task){
        let taskInfo = info.taskInfo
        self.missionTitleLabel.text = taskInfo?.title
        self.missionDescribLabel.text = taskInfo?.desc
        self.missionRemarkLabel.text = taskInfo?.remark
    }
    
    
    func viewHeight() -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        
        let titleH = UILabel.cz_labelHeight(withText: self.missionTitleLabel.text, size: size, font: self.missionTitleLabel.font)
        let describH = UILabel.cz_labelHeight(withText: self.missionDescribLabel.text, size: size, font: self.missionDescribLabel.font)
        let remarkH = UILabel.cz_labelHeight(withText: self.missionRemarkLabel.text, size: size, font: self.missionRemarkLabel.font)
        
        //(10+17+10+titleH+10+17+10+describH+10+17+10+remarkH)
        return (kResizedPoint(pt: 111) + titleH + describH + remarkH)
    }
    
    
}

extension CarryMissionInfoView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.missionTitleNameLabel)
        self.contentView.addSubview(self.missionTitleLabel)
        self.contentView.addSubview(self.missionDescribNameLabel)
        self.contentView.addSubview(self.missionDescribLabel)
        self.contentView.addSubview(self.missionRemarkNameLabel)
        self.contentView.addSubview(self.missionRemarkLabel)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
    
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.bottom.equalTo()(self.mas_bottom)
        }
        
        self.missionTitleNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.missionTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.missionTitleNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.missionTitleNameLabel.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.missionDescribNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.missionTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.missionDescribLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.missionDescribNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.missionTitleNameLabel.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.missionRemarkNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.missionDescribLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.missionRemarkLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.missionRemarkNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.missionTitleNameLabel.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        
        
    }
    
}
