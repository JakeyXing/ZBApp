//
//  SettingViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/19.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
class SettingViewController: UIViewController,JHNavigationBarDelegate {
    
    

    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = "设置"
        view.delegate = self
        return view
    }()
    
    private lazy var bgViewView: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - navigationBarHeight))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var nLabel: UILabel = UILabel.cz_label(withText: "语言版本", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var nDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = "中文繁体"
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["中文繁体","日文","English"]
        return view
    }()
    
    lazy var savedButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle("保存并重启应用", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.bgViewView)
        self.bgViewView.addSubview(self.nLabel)
        self.bgViewView.addSubview(self.nDropdownView)
        self.bgViewView.addSubview(self.savedButton)
        
        self.nLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.bgViewView.mas_top)?.offset()(kResizedPoint(pt: 30))
            make.left.equalTo()(self.view.mas_left)?.offset()(kResizedPoint(pt: 70))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.nDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.nLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.centerY.equalTo()(self.nLabel.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.savedButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.nDropdownView.mas_bottom)?.offset()(kResizedPoint(pt: 40))
            make.width.equalTo()(kResizedPoint(pt: 260))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        
    }
    

    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightAction() {
        
    }
    
    @objc private func sureAction(){
   
        
    }

}
