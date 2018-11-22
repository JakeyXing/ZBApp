//
//  MissionBaseInfoView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class MissionBaseInfoView: UIView {

    //MARK: - 控件
    
    private lazy var statusLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
    private lazy var dateLabel: UILabel = UILabel.cz_label(withText: "2018-07-22", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var typeLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.textAlignment = NSTextAlignment.center
        lab.font = kFont(size: 16)
        lab.backgroundColor = kTintColorYellow
        lab.text = ""
        return lab
        
    }()
    
    lazy var timeLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var starImage_1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "wenhao")
        return img
    }()
    
    private lazy var salaryLabel_1: UILabel = UILabel.cz_label(withText: "2300 JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    private lazy var salaryTitleLabel_1: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.base.base"), fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var starImage_2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "wenhao")
        return img
    }()
    
    private lazy var salaryLabel_2: UILabel = UILabel.cz_label(withText: "2000 JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    private lazy var salaryTitleLabel_2: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.base.bonus"), fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var addressLabel: UILabel = UILabel.cz_label(withText: "浪速区大国2-10-7 難波南", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var cleanWorkTimeL: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.clean.worktime"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var addressIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        return img
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MissionBaseInfoView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.statusLabel)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.typeLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.starImage_1)
        self.contentView.addSubview(self.salaryLabel_1)
        self.contentView.addSubview(self.salaryTitleLabel_1)
        self.contentView.addSubview(self.starImage_2)
        self.contentView.addSubview(self.salaryLabel_2)
        self.contentView.addSubview(self.salaryTitleLabel_2)
        self.contentView.addSubview(self.addressIcon)
        self.contentView.addSubview(self.cleanWorkTimeL)
        self.contentView.addSubview(self.addressLabel)

        self.subViewsLayout()
    }
    
    //
    func congfigDataWithTaskInfo(info: ZB_TaskInfo){
       
        let timeInterv = timeToTimeStamp(time: info.startDate ?? "")
        self.statusLabel.text = statusNameWithStr(str: info.status ?? "")
        self.dateLabel.text = timeStampToString(timeStamp: timeInterv)
        self.typeLabel.text = typeNameWithStr(str: info.type ?? "")
        
        let starTimeStr = timeStampShortTimeStr(timeStamp: timeInterv)
        let endTimeStr = timeStampShortTimeStr(timeStamp: (timeInterv + Double(info.restHours + info.hoursPerPerson)*3600))
        
        if info.type == "CLEAN" {
            if info.properties?.count ?? 0 > 0 {
                let taskProperty = info.properties?[0]
                self.timeLabel.text = taskProperty?.doorplate
            }
            
        }else{
            self.timeLabel.text = starTimeStr + "-" + endTimeStr + String(format: "(%@%dh)", LanguageHelper.getString(key: "detail.base.rest"),info.restHours)
        }
    
        self.salaryLabel_1.text = String(format: "%.0f %@",info.base,info.currency ?? "JPY")
        self.salaryLabel_2.text = String(format: "%.0f %@",info.bonus,info.currency ?? "JPY")
        
        self.addressLabel.text = info.address?.name
    }
    
    //
    func congfigDataWithTask(info: ZB_Task){
        let progress:String = info.progress ?? "READY"
        let currentProgress = ZB_ProgressType(rawValue: progress) ?? .ready
        self.statusLabel.text = progressNameWithProgress(progerss: currentProgress)
        
        let taskInfo = info.taskInfo
        let timeInterv = timeToTimeStamp(time: taskInfo?.startDate ?? "")
        self.dateLabel.text = timeStampToString(timeStamp: timeInterv)
        self.typeLabel.text = typeNameWithStr(str: taskInfo?.type ?? "")
        
        let starTimeStr = timeStampShortTimeStr(timeStamp: timeInterv)
        let restHoursPerPerson = taskInfo?.restHoursPerPerson ?? 0
        let hoursPerPerson = taskInfo?.hoursPerPerson ?? 0
        let worktime = restHoursPerPerson + hoursPerPerson
        let endTimeStr = timeStampShortTimeStr(timeStamp: (timeInterv + Double(worktime*3600)))
        
        if taskInfo?.type == "CLEAN" {
            if taskInfo?.properties?.count ?? 0 > 0 {
                let taskProperty = taskInfo?.properties?[0]
                self.timeLabel.text = taskProperty?.doorplate
            }
            
        }else{
            self.timeLabel.text = starTimeStr + "-" + endTimeStr + String(format: "(%@%dh)", LanguageHelper.getString(key: "detail.base.rest"),info.restHours)
        }
        
        self.salaryLabel_1.text = String(format: "%.0f %@", taskInfo?.base ?? 0,taskInfo?.currency ?? "JPY")
        self.salaryLabel_2.text = String(format: "%.0f %@", taskInfo?.bonus ?? 0,taskInfo?.currency ?? "JPY")
        
        self.addressLabel.text = taskInfo?.address?.name
        
    }
    
    
    func subViewsLayout(){
        self.statusLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.statusLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 125))
        }
        
        self.dateLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(25)
        }
        
        self.typeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.dateLabel.mas_centerY)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.width.equalTo()(kResizedPoint(pt: 60))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.dateLabel.mas_bottom)?.offset()(kResizedPoint(pt: 15))
            make.left.equalTo()(self.dateLabel.mas_left)
            make.height.equalTo()(25)
        }
        
        self.salaryLabel_1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
            
        }
        
        self.starImage_1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
            make.right.equalTo()(self.salaryLabel_1.mas_left)?.offset()(kResizedPoint(pt: -5))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.salaryTitleLabel_1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
            make.right.equalTo()(self.starImage_1.mas_left)?.offset()(kResizedPoint(pt: 0))
            
        }
        
        self.salaryLabel_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.salaryLabel_1.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.salaryLabel_1.mas_right)
            
        }
        
        self.starImage_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.salaryLabel_2.mas_centerY)
            make.right.equalTo()(self.salaryLabel_2.mas_left)?.offset()(kResizedPoint(pt: -5))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.salaryTitleLabel_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.salaryLabel_2.mas_centerY)
            make.right.equalTo()(self.starImage_2.mas_left)?.offset()(kResizedPoint(pt: 0))
            
        }

        self.cleanWorkTimeL.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.timeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 40))
            make.left.equalTo()(self.dateLabel.mas_left)
            make.height.equalTo()(0)
        }
        
        self.addressLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.timeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 35))
            make.left.equalTo()(self.dateLabel.mas_left)
        }
        
        self.addressIcon.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.addressLabel.mas_centerY)
            make.left.equalTo()(self.addressLabel.mas_right)?.offset()(kResizedPoint(pt: 3))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
    }
    
    
}


