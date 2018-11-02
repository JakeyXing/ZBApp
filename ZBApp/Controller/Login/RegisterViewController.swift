//
//  RegisterViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import BEMCheckBox
import Toast
import MBProgressHUD
class RegisterViewController: UIViewController,BEMCheckBoxDelegate {
    
    var remainingSeconds = 0 {
        willSet {
            self.sendCodeButton.setTitle("\(newValue)", for: .normal)
            
            if newValue <= 0 {
                self.sendCodeButton.setTitle(LanguageHelper.getString(key: "register.pageItem.sendCode"), for: .normal)
                isCounting = false
            }
        }
    }
    
    var countdownTimer: Timer?
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegisterViewController.updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 300
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
            }
            
            self.sendCodeButton.isEnabled = !newValue
        }
    }
    
    @IBOutlet weak var showPassLabel: UILabel!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var areaCodeTitleLabel: UILabel!
    @IBOutlet weak var codeTitleLabel: UILabel!
    @IBOutlet weak var passTitleLabel: UILabel!
    
    @IBOutlet weak var areaDropdownView: JHDropdownView!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var vertyCodeTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBOutlet weak var checkbox: BEMCheckBox!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendCodeButton.setTitleColor(kFontColorGray, for: .disabled)
        
        self.checkbox.boxType = BEMBoxType.square
        self.checkbox.onFillColor = kTintColorYellow
        self.checkbox.onTintColor = kTintColorYellow
        self.checkbox.onCheckColor = UIColor.white
        self.checkbox.delegate = self
        self.navTitleLabel.text = LanguageHelper.getString(key: "login.pageItem.register")
        self.areaCodeTitleLabel.text = LanguageHelper.getString(key: "login.pageItem.areaCode")
        self.codeTitleLabel.text = LanguageHelper.getString(key: "register.pageItem.code")
        self.passTitleLabel.text = LanguageHelper.getString(key: "register.pageItem.password")
        self.phoneTextfield.placeholder = LanguageHelper.getString(key: "login.pageItem.phone")
        self.vertyCodeTextfield.placeholder = LanguageHelper.getString(key: "register.pageItem.sendCodeTip")
        self.passwordTextfield.placeholder = LanguageHelper.getString(key: "register.pageItem.passwordTip")
        self.showPassLabel.text = LanguageHelper.getString(key: "login.pageItem.showPassword")
        
        self.sendCodeButton.setTitle(LanguageHelper.getString(key: "register.pageItem.sendCode"), for: .normal)
        self.registerButton.setTitle(LanguageHelper.getString(key: "apply.nav.submit"), for: .normal)
        
        self.areaDropdownView.contentLabel.text = "+86"
        self.areaDropdownView.contentLabel.textColor = kFontColorBlack
        self.areaDropdownView.dataArray = ["+86","+81","+61"]
        self.areaDropdownView.extraTop = 0
 
    }
    
    //发送验证码
    @IBAction func sendVerCodeAction(_ sender: Any) {
        if self.phoneTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.phoneTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        let str:String = self.areaDropdownView.contentLabel.text ?? ""
        let countryCode :String = String(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])
        let params = ["countryCode":countryCode,"phone":self.phoneTextfield.text!] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadNoTokenRequest(method: .get, url: PhoneCodeUrl, parameters: params as [String : Any], success: { (data) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            //开始倒计时
            self.isCounting = true
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
        }
        

    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
    

    //注册
    @IBAction func submitAction(_ sender: Any) {
        if self.phoneTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.phoneTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if self.vertyCodeTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "register.pageItem.sendCodeTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if self.passwordTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.passwordTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        let str:String = self.areaDropdownView.contentLabel.text ?? ""
        let countryCode :String = String(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])
        
        let code = Int(self.vertyCodeTextfield.text ?? "0")
        let params = ["countryCode":countryCode,"phone":self.phoneTextfield.text!,"password":self.passwordTextfield.text!,"vertyCode":self.vertyCodeTextfield.text!,"code":code!] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadNoTokenRequest(method: .post, url: RegisterUrl, parameters: params as [String : Any], success: { (data) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            let resultDic = data as! Dictionary<String,AnyObject>
            let  accessToken = resultDic["accessToken"]
            let  refreshToken = resultDic["refreshToken"]
            setAccessToken(token: accessToken as! String)
            setRefreshToken(token: refreshToken as! String)
            
            setUserInfo(info: resultDic["data"] as! Dictionary<String, Any>)
            
            if getUserStatus() == .review_pass{
                let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                sharedAppdelegate.window?.rootViewController = sharedAppdelegate.mainTabBarVc
            }else{
                let reply = CertifApplyController()
                reply.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(reply, animated: true)
            }
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
        }
        
    }

    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        self.passwordTextfield.isSecureTextEntry = !self.checkbox.on
    }
}
