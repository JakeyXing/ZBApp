//
//  ResetPasswordViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import BEMCheckBox
import MBProgressHUD
import Toast

class ResetPasswordViewController: UIViewController,BEMCheckBoxDelegate {

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
                
                remainingSeconds = 90
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
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkbox.boxType = BEMBoxType.square
        self.checkbox.onFillColor = kTintColorYellow
        self.checkbox.onTintColor = kTintColorYellow
        self.checkbox.onCheckColor = UIColor.white
        self.checkbox.delegate = self
        self.navTitleLabel.text = LanguageHelper.getString(key: "login.pageItem.resetPass")
        self.areaCodeTitleLabel.text = LanguageHelper.getString(key: "login.pageItem.areaCode")
        self.codeTitleLabel.text = LanguageHelper.getString(key: "register.pageItem.code")
        self.passTitleLabel.text = LanguageHelper.getString(key: "register.pageItem.password")
        self.phoneTextfield.placeholder = LanguageHelper.getString(key: "login.pageItem.phone")
        self.vertyCodeTextfield.placeholder = LanguageHelper.getString(key: "register.pageItem.sendCodeTip")
        self.passwordTextfield.placeholder = LanguageHelper.getString(key: "register.pageItem.passwordTip")
        self.showPassLabel.text = LanguageHelper.getString(key: "login.pageItem.showPassword")
        
        self.sendCodeButton.setTitle(LanguageHelper.getString(key: "register.pageItem.sendCode"), for: .normal)
        self.submitButton.setTitle(LanguageHelper.getString(key: "apply.nav.submit"), for: .normal)
        
        self.areaDropdownView.contentLabel.text = "+86"
        self.areaDropdownView.contentLabel.textColor = kFontColorBlack
        self.areaDropdownView.dataArray = ["+86","+81","+61"]
        self.areaDropdownView.extraTop = 0
       
    }


    @IBAction func sendVerCodeAction(_ sender: Any) {
        if self.phoneTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.phoneTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        let str:String = self.areaDropdownView.contentLabel.text ?? ""
        let countryCode :String = String(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])
        
        let code = Int(self.vertyCodeTextfield.text ?? "0")
        let params = ["countryCode":countryCode,"phone":self.phoneTextfield.text!,"password":self.passwordTextfield.text!,"vertyCode":self.vertyCodeTextfield.text!,"code":code!] as [String : Any]
        
        
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
    
    //提交
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
        
        let passMd5 = self.passwordTextfield.text?.md5WithSalt(salt: self.phoneTextfield.text!)
        
        let params = ["countryCode":self.areaDropdownView.contentLabel.text,"phone":self.phoneTextfield.text,"password":passMd5,"vertyCode":self.vertyCodeTextfield.text]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadNoTokenRequest(method: .post, url: ResetPassUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
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
