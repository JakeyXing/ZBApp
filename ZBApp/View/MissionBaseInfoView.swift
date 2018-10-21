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
    
    private lazy var statusLabel: UILabel = UILabel.cz_label(withText: "已完成", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
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
        lab.text = "搬场"
        return lab
        
    }()
    
    private lazy var timeLabel: UILabel = UILabel.cz_label(withText: "9:00-18:00(休息1h)", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var starImage_1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starr")
        return img
    }()
    
    private lazy var salaryLabel_1: UILabel = UILabel.cz_label(withText: "基本薪资 2300 JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var starImage_2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starr")
        return img
    }()
    
    private lazy var salaryLabel_2: UILabel = UILabel.cz_label(withText: "其他薪资 2000 JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var addressLabel: UILabel = UILabel.cz_label(withText: "浪速区大国2-10-7 難波南", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
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
    
    //MARK: - actions
  
    @objc private func starImageTapped(){
//        self.delegate?.rightAction()
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
        self.contentView.addSubview(self.starImage_2)
        self.contentView.addSubview(self.salaryLabel_2)
        self.contentView.addSubview(self.addressIcon)
        self.contentView.addSubview(self.addressLabel)
        
        self.subViewsLayout()
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
        }
        
        self.starImage_1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -38))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.salaryLabel_1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.starImage_1.mas_centerY)
            make.right.equalTo()(self.starImage_1.mas_left)?.offset()(kResizedPoint(pt: -2))
        }
        
        self.starImage_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.starImage_1.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.starImage_1.mas_right)
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.salaryLabel_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.starImage_2.mas_centerY)
            make.right.equalTo()(self.starImage_2.mas_left)?.offset()(kResizedPoint(pt: -2))
        }
        
        self.addressLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.timeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 40))
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


