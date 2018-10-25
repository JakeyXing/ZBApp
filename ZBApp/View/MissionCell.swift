//
//  MissionCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/8.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class MissionCell: UITableViewCell {
    //MARK: - 控件
    private var model: ZB_TaskInfo?
    private lazy var timeLabel: UILabel = UILabel.cz_label(withText: "2018-07-22", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    private lazy var priceLabel: UILabel = UILabel.cz_label(withText: "2300~3500", fontSize: kResizedFont(ft: 16), color: kTintColorYellow)
    
    private lazy var unitLabel: UILabel = UILabel.cz_label(withText: "JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    private lazy var locaLabel: UILabel = UILabel.cz_label(withText: "浪速区大国", fontSize: 16, color: kFontColorGray)
    
//    private lazy var starView: StarView = {
//        let view = StarView()
//        view.backgroundColor = kTintColorYellow
//        return view
//    }()
    lazy var addressIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        return img
    }()
    
    private lazy var requireLabel: UILabel = {
        let require = UILabel()
        require.font = kFont(size: 13)
        require.textColor = kFontColorGray;
        require.textAlignment = NSTextAlignment.right
        require.text = "完成任务，经检查合格且无客诉，可额外获得1300JPY"
        return require
    }()
    
    private lazy var typeLabel: UILabel = {
        let type = UILabel()
        type.font = kFont(size: 16)
        type.textColor = kFontColorGray_177;
        type.textAlignment = NSTextAlignment.center
        type.backgroundColor = UIColor.white
        type.text = "清扫"
        return type
    }()
    
    private lazy var numLabel: UILabel = UILabel.cz_label(withText: "8+1/10", fontSize: 14, color: kFontColorGray)
    
    private lazy var stateLabel: UILabel = UILabel.cz_label(withText: "待开始", fontSize: 14, color: kFontColorGray)
    
    private lazy var bottomCapView: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
     //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = RGBCOLOR(r: 238, 235, 220)
        self.setUpUI()
        self.subViewsLayout()
    }
    
    
    //MARK: - private method
    func setUpData(model:ZB_TaskInfo) {
        self.model = model;
        self.timeLabel.text = model.startDate
        
    }
    
    func setUpUI(){
        self.addSubview(timeLabel)
        self.addSubview(priceLabel)
        self.addSubview(unitLabel)
        self.addSubview(locaLabel)
        self.addSubview(addressIcon)
        self.addSubview(requireLabel)
        self.addSubview(typeLabel)
        self.addSubview(numLabel)
        self.addSubview(stateLabel)
        self.addSubview(bottomCapView)
    }
    
    func subViewsLayout(){
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 20))
        }
        
        self.unitLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
        }
        
        self.priceLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.unitLabel.mas_left)?.offset()(kResizedPoint(pt: -3))
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
        }
        
        self.addressIcon.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.top.equalTo()(self.unitLabel.mas_bottom)?.offset()(kResizedPoint(pt: 15))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.locaLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.addressIcon.mas_left)?.offset()(kResizedPoint(pt: -5))
            make.centerY.equalTo()(self.addressIcon.mas_centerY)
        }
        
        self.requireLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.lessThanOrEqualTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.top.equalTo()(self.locaLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
        }
        
        self.typeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.top.equalTo()(self.requireLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.width.equalTo()(kResizedPoint(pt: 46))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.numLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.typeLabel.mas_right)?.offset()(kResizedPoint(pt: 90))
            make.centerY.equalTo()(self.typeLabel.mas_centerY)
        }
        
        self.stateLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.numLabel.mas_right)?.offset()(kResizedPoint(pt: 50))
            make.centerY.equalTo()(self.typeLabel.mas_centerY)
        }
        
        self.bottomCapView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.right()?.bottom().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 10))
        }
        
    }
    

}
