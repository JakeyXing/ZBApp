//
//  JHNavigationBar.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/9.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

protocol JHNavigationBarDelegate: class {
    func leftAction()
    func rightAction()
}

class JHNavigationBar: UIView {
    //MARK: - delegate
    weak var delegate: JHNavigationBarDelegate?
    
    //MARK: - 控件
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.clear
        return content
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton(type: UIButton.ButtonType.custom)
        back.setImage(UIImage(named: "newBack"), for: UIControl.State.normal)
        back.addTarget(self, action: #selector(leftAction), for: UIControl.Event.touchUpInside)
        return back
    }()
    
    lazy var titleView: UIView = {
        let titleV = UIView()
        titleV.backgroundColor = UIColor.clear
        return titleV
    }()
    
    lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = RGBCOLOR(r: 46, 46, 46)
        lab.textAlignment = NSTextAlignment.center
        lab.font = kFont(size: 17)
        return lab
        
    }()
    
    lazy var editButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(RGBCOLOR(r: 46, 46, 46), for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(rightAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = RGBCOLOR(r: 223, 223, 223)
        return view
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: navigationBarHeight))
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - actions
    @objc private func leftAction(){
        self.delegate?.leftAction()
        
    }
    
    @objc private func rightAction(){
        self.delegate?.rightAction()
    }
    
   
}

extension JHNavigationBar{
    
     //MARK: - private methods
    
    func initView(){
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.backButton)
        self.contentView.addSubview(self.titleView)
        self.titleView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.editButton)
        self.contentView.addSubview(self.bottomLine)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(statusBarHeight)
            make.left.right().equalTo()(self)
            make.height.equalTo()(44)
        }
        
        self.backButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 10))
            make.centerY.equalTo()(self.contentView.mas_centerY)
            make.width.height().equalTo()(kResizedPoint(pt: 44))
        }

        self.titleView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.equalTo()(self.contentView.center)
            make.width.equalTo()(kResizedPoint(pt: 200))
            make.height.equalTo()(44)
        }
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.equalTo()(self.titleView.center)
            make.width.equalTo()(kResizedPoint(pt: 200))
            make.height.equalTo()(44)
        }
        
        self.editButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -10))
            make.centerY.equalTo()(self.contentView.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 44))
            make.height.equalTo()(kResizedPoint(pt: 44))
        }
        
        self.bottomLine.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.right().equalTo()(self.contentView)
            make.bottom.equalTo()(self.contentView.mas_bottom)
            make.height.equalTo()(kResizedPoint(pt: 0.5))
        }
    }

}
