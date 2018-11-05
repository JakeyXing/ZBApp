//
//  RepairInfoTextView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry


/// 维修图片、视频上传 数量说明
class RepairInfoTextView: UIView {
    
    private lazy var resultNameLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.repairPic.uploadResult"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var resultLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: RGBCOLOR(r: 254, 0, 5))
    
    private lazy var infoTextView: UITextView = {
        let text = UITextView()
        return text
        
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func congfigData() {
    
    }
    
    func viewHeight() -> CGFloat {

        return kResizedPoint(pt: 10+17+10+150+5)
    }
    
    
}

extension RepairInfoTextView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = kBgColorGray_238_235_220
        
        self.addSubview(self.resultNameLabel)
        self.addSubview(self.resultLabel)
        self.addSubview(self.infoTextView)
      
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.resultNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.resultLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.resultNameLabel.mas_centerY)
            make.left.equalTo()(self.resultNameLabel.mas_right)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.infoTextView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.resultNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.height.equalTo()(kResizedPoint(pt: 150))
        }
        
    }
    
}
