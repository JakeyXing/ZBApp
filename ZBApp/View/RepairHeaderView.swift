//
//  RepairHeaderView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/15.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class RepairHeaderView: UICollectionReusableView {
    
    //MARK: - 控件
    lazy var roomNumTiLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.PicUpload.roomNo"), fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var roomNumLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    lazy var uploadTitle: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.repairPic.uploadTitle"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var capView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
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

extension RepairHeaderView{
    
    //MARK: - private methods
    
    func initView(){
        self.addSubview(self.capView)
        self.addSubview(self.roomNumTiLabel)
        self.addSubview(self.roomNumLabel)
        self.addSubview(self.uploadTitle)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        self.capView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.right().equalTo()(self)
            make.top.equalTo()(self.mas_top)
            make.height.equalTo()(kResizedPoint(pt: 10))
            
        }
        
        self.roomNumTiLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.capView.mas_bottom)?.offset()(kResizedPoint(pt:10))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 5))
            make.height.equalTo()(kResizedPoint(pt: 19))
        }
        
        self.roomNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.roomNumTiLabel.mas_right)
            make.centerY.equalTo()(self.roomNumTiLabel.mas_centerY)
        }
        
        self.uploadTitle.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 10))
            make.top.equalTo()(self.roomNumTiLabel.mas_bottom)?.offset()(kResizedPoint(pt:5))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        //10+10+19+5+17
    }
    
}

