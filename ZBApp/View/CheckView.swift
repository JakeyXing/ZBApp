//
//  CheckView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class CheckView: UIView {
    
    lazy var titleLabel: UILabel = UILabel.cz_label(withText: "验收结果", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = "非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀非常好呀"
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
    
    func congfigData() {
        
        
    }
    
    
    func viewHeight() -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        let h = UILabel.cz_labelHeight(withText: self.contentLabel.text, size: size, font: self.contentLabel.font)
        
        //17+10+h
        return h+kResizedPoint(pt: 27)
    }
    
    
}

extension CheckView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.contentLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.titleLabel.mas_left)
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
    }
    
}
