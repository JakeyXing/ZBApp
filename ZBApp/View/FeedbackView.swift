//
//  FeedbackView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class FeedbackView: UIView {
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
    lazy var timeLabel: UILabel = UILabel.cz_label(withText: "2018-09-12 12:09:12", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var feebackLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = "海外网10月12日电当地时间10月12日，2018年“新学院奖”在瑞典斯德哥尔摩公共图书馆揭晓，玛丽斯·孔戴(Maryse Condé)获得此奖项"
        lab.numberOfLines = 0
        return lab
        
    }()
    
    lazy var picButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(RGBCOLOR(r: 254, 0, 5), for: UIControl.State.normal)
        btn.setTitle("查看图片", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(picAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(RGBCOLOR(r: 115, 115, 115), for: UIControl.State.normal)
        btn.setTitle("查看更多日志", for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(moreAction), for: UIControl.Event.touchUpInside)
        return btn
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
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        let fbH = UILabel.cz_labelHeight(withText: self.feebackLabel.text, size: size, font: self.feebackLabel.font)
        //10+17+10+h+10+20+10
        let contentH = kResizedPoint(pt: 77)+fbH
        self.contentView.mas_updateConstraints{ (make:MASConstraintMaker!) in
            make.height.equalTo()(contentH)
        }
        
        
    }
    
    //MARK: - actions
    @objc private func picAction(){
        
    }
    
    @objc private func moreAction(){

    }
    
    
    func viewHeight() -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        
        let fbH = UILabel.cz_labelHeight(withText: self.feebackLabel.text, size: size, font: self.feebackLabel.font)
        let contentH = kResizedPoint(pt: 77)+fbH
        
        //10 +17+10+h+
        return contentH+kResizedPoint(pt: 10+18)
    }
    
    
}

extension FeedbackView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.feebackLabel)
        self.contentView.addSubview(self.picButton)
        self.addSubview(self.moreButton)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.feebackLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.timeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.timeLabel.mas_left)
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.picButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.feebackLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.width.equalTo()(kResizedPoint(pt: 70))
            make.height.equalTo()(kResizedPoint(pt: 20))
            
        }
        
        self.moreButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.width.equalTo()(kResizedPoint(pt: 96))
            make.height.equalTo()(kResizedPoint(pt: 18))
        }
     
    }
    
}