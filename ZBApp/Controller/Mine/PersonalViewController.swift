//
//  PersonalViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import MBProgressHUD
import Toast
import ObjectMapper

class PersonalViewController: UIViewController {

    var user: ZB_User?
    lazy var headImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "defaultHear")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = kResizedPoint(pt: 24)
        img.clipsToBounds = true
//        img.isUserInteractionEnabled = true
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(headImageViewTapped))
//        img.addGestureRecognizer(tap1)
        return img
    }()
    
     private lazy var nameLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var star:StarView = StarView()
    
    lazy var beseInfoButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.setTitle(LanguageHelper.getString(key: "mine.btns.baseInfo"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "func"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        
        btn.addTarget(self, action: #selector(baseAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var bankInfoButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.setTitle("银行账户", for: UIControl.State.normal)
        btn.setImage(UIImage(named: "func"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(bankAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var settingButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.setTitle(LanguageHelper.getString(key: "mine.btns.setting"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "func"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        
        btn.addTarget(self, action: #selector(settingAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.headImageView)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.star)
        self.view.addSubview(self.beseInfoButton)
        self.view.addSubview(self.bankInfoButton)
        self.view.addSubview(self.settingButton)
        
        self.headImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)?.offset()(kResizedPoint(pt: 26))
            make.top.equalTo()(self.view.mas_top)?.offset()(statusBarHeight + kResizedPoint(pt: 25))
            make.width.equalTo()(kResizedPoint(pt: 48))
            make.height.equalTo()(kResizedPoint(pt: 48))
        }
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.headImageView.mas_right)?.offset()(kResizedPoint(pt: 12))
            make.centerY.equalTo()(self.headImageView.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 160))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.star.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.view.mas_right)?.offset()(kResizedPoint(pt: -26))
            make.centerY.equalTo()(self.headImageView.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 160))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.beseInfoButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)?.offset()(kResizedPoint(pt: 26))
            make.top.equalTo()(self.star.mas_bottom)?.offset()(kResizedPoint(pt: 30))
            make.width.equalTo()(kResizedPoint(pt: 65))
            make.height.equalTo()(kResizedPoint(pt: 32+17+10))
        }
        
        self.bankInfoButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.beseInfoButton.mas_right)?.offset()(kResizedPoint(pt: 15))
            make.centerY.equalTo()(self.beseInfoButton.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 65))
            make.height.equalTo()(kResizedPoint(pt: 32+17+10))
        }
        
        self.settingButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.bankInfoButton.mas_right)?.offset()(kResizedPoint(pt: 15))
            make.centerY.equalTo()(self.beseInfoButton.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 32+17+10))
        }
        self.beseInfoButton.layoutButton(with: MKButtonEdgeInsetsStyle.top, imageTitleSpace: kResizedPoint(pt: 3))
        self.bankInfoButton.layoutButton(with: MKButtonEdgeInsetsStyle.top, imageTitleSpace: kResizedPoint(pt: 3))
        self.settingButton.layoutButton(with: MKButtonEdgeInsetsStyle.top, imageTitleSpace: kResizedPoint(pt: 3))
        
        self.loadData()
        
    }
    
    func loadData(){
        
        let params = [:] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .get, url: UserInfoUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
            
            let user = Mapper<ZB_User>().map(JSON: dic as! [String : Any])
            self.user = user
            self.configData()
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    func configData() {
        self.nameLabel.text = self.user?.userName
        headImageView.sd_setImage(with: URL(string: user?.userImgUrl ?? ""), placeholderImage: UIImage(named: "defaultHear"), options: [], completed: nil)
        self.star.levelLabel.text =  String(format: "%@%@", LanguageHelper.getString(key: "personal.base.userLevel"),self.user?.userLevel ?? "")
        
    }
    
    //MARK: - actions
    @objc private func baseAction(){
        let info=PersonalInfoController()
        info.hidesBottomBarWhenPushed = true
        info.user = self.user
        self.navigationController?.pushViewController(info, animated: true)
        
    }
    
    @objc private func bankAction(){
        let bank=BankAccountController()
        bank.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bank, animated: true)
        
    }
    
    @objc private func settingAction(){
        let set = SettingViewController()
        set.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(set, animated: true)
    }

}
