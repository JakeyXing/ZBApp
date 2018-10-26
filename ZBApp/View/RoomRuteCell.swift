//
//  RoomRuteCell.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class RoomRuteCell: UITableViewCell {
    //MARK: - 控件
    private lazy var roomNumLabel: UILabel = UILabel.cz_label(withText: "版大国UR0201", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
//    private lazy var passwordTitleLabel: UILabel = UILabel.cz_label(withText: "12344", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var passwordButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setImage(UIImage(named: "doorpass_s"), for: .normal)
        return btn
    }()
    
    lazy var routeButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(RGBCOLOR(r: 0, 1, 253), for: UIControl.State.normal)
        btn.setTitle(LanguageHelper.getString(key: "detail.roomInfo.lookRoute"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(routeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.setUpUI()
        self.subViewsLayout()
    }
    
    
    //MARK: - private method
    func setUpUI(){
        self.addSubview(roomNumLabel)
//        self.addSubview(passwordTitleLabel)
        self.addSubview(passwordButton)
        self.addSubview(routeButton)
    }
    
    func configData(model: ZB_TaskProperty){
        
    }
    
    @objc private func routeAction() {
        
    }
    
    func subViewsLayout(){
        self.roomNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 70))
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 5))
        }
        
//        self.passwordTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.centerX.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 196))
//            make.centerY.equalTo()(self.roomNumLabel.mas_centerY)
//        }
        
        self.passwordButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 196))
            make.centerY.equalTo()(self.roomNumLabel.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 26))
        }
        
        self.routeButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 282))
            make.centerY.equalTo()(self.roomNumLabel.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 26))
        }
        
        
       
        
    }
    
    
}
