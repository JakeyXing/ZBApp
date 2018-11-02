//
//  SettingViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/19.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import MBProgressHUD
class SettingViewController: UIViewController,JHNavigationBarDelegate {
    
    

    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "mine.btns.setting")
        view.delegate = self
        return view
    }()
    
    private lazy var bgViewView: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - navigationBarHeight))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var nLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "setting.langue.title"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var nDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = "繁体中文"
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["繁體中文","中文简体","日文","English"]
        return view
    }()
    
    lazy var cleaneCacheButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "setting.btn.cleanCache"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(cleanAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var loginoutButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "setting.btn.exit"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(loginoutAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var savedButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "setting.btn.saveAndRestart"), for: .normal)
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
        self.bgViewView.addSubview(self.cleaneCacheButton)
        self.bgViewView.addSubview(self.loginoutButton)
        
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
        
        self.cleaneCacheButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.savedButton.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 260))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.loginoutButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.cleaneCacheButton.mas_bottom)?.offset()(kResizedPoint(pt: 50))
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
        let lague = self.nDropdownView.contentLabel.text!
        if lague == "中文简体"{
            LanguageHelper.shareInstance.setLanguage(langeuage: "zh-Hans")
            
        }else if lague == "日文"{
            LanguageHelper.shareInstance.setLanguage(langeuage: "ja")
            
        }else if lague == "繁體中文"{
            LanguageHelper.shareInstance.setLanguage(langeuage: "zh-Hant")
            
        }
        else{
            LanguageHelper.shareInstance.setLanguage(langeuage: "en")
            
        }
      
    }
    
    @objc private func cleanAction(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CommonMethod.deleteAwsFiles()
        MBProgressHUD.hide(for: self.view, animated: true)
        
        
    }
    
    @objc private func loginoutAction(){
        
        setUserInfo(info: [:])
        setAccessToken(token: "")
        setRefreshToken(token: "")
        
        let loginVC = LoginViewController()
        let naviVC = UINavigationController(rootViewController: loginVC)
        
        let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        sharedAppdelegate.window?.rootViewController = naviVC

        
    }

}
