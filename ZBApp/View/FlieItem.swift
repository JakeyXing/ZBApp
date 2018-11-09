//
//  FlieItem.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry


/// 文件占位
class FlieItem: UIControl {
    
    //MARK: - 控件
    lazy var fielImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        return img
    }()
 
    lazy var fileNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.backgroundColor = kBgColorGray_238_235_220
        lab.textAlignment = NSTextAlignment.center
        lab.font = kFont(size: 15)
        lab.text = ""
        lab.numberOfLines = 2
        lab.lineBreakMode = .byTruncatingMiddle
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
    
    
}

extension FlieItem{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.clear
        self.addSubview(self.fielImageView)
        self.addSubview(self.fileNameLabel)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        self.fielImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 98))
        }
        
        self.fileNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.fielImageView.mas_bottom)?.offset()(kResizedPoint(pt: 2))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: -5))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: 5))
        }
       
    
    }
    
}
