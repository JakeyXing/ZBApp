//
//  LoginViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import BEMCheckBox
import Toast
import MBProgressHUD

class LoginViewController: UIViewController,BEMCheckBoxDelegate {
    @IBOutlet weak var showPassLabel: UILabel!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var areaCodeTitleLabel: UILabel!
    
    @IBOutlet weak var areaDropdownView: JHDropdownView!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var checkbox: BEMCheckBox!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navTitleLabel.text = LanguageHelper.getString(key: "login.nav.title")
        self.areaCodeTitleLabel.text = LanguageHelper.getString(key: "login.pageItem.areaCode")
        self.phoneTextfield.placeholder = LanguageHelper.getString(key: "login.pageItem.phone")
        self.passwordTextfield.placeholder = LanguageHelper.getString(key: "login.pageItem.password")
        self.registerButton.setTitle(LanguageHelper.getString(key: "login.pageItem.register"), for: .normal)
        self.resetPasswordButton.setTitle(LanguageHelper.getString(key: "login.pageItem.resetPass"), for: .normal)
        self.loginButton.setTitle(LanguageHelper.getString(key: "login.nav.title"), for: .normal)
        self.showPassLabel.text = LanguageHelper.getString(key: "login.pageItem.showPassword")
        
        self.checkbox.boxType = BEMBoxType.square
        self.checkbox.onFillColor = kTintColorYellow
        self.checkbox.onTintColor = kTintColorYellow
        self.checkbox.onCheckColor = UIColor.white
        self.checkbox.delegate = self
        
        self.areaDropdownView.contentLabel.text = "+86"
        self.areaDropdownView.contentLabel.textColor = kFontColorBlack
        self.areaDropdownView.dataArray = ["+86","+81","+61"]
        self.areaDropdownView.extraTop = 0
    }

    @IBAction func loginAction(_ sender: Any) {
        if self.phoneTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.phoneTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if self.passwordTextfield.text?.count == 0 {
            self.view.makeToast(LanguageHelper.getString(key: "login.pageItem.passwordTip"), duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        let passMd5 = self.passwordTextfield.text?.md5WithSalt(salt: self.phoneTextfield.text!)
        
        let str:String = self.areaDropdownView.contentLabel.text ?? ""
        let countryCode :String = String(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])
        let params = ["countryCode":countryCode,"phone":self.phoneTextfield.text!,"password":passMd5!]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadNoTokenRequest(method: .post, url: LoginUrl, parameters: params as [String : Any], success: { (data) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            let resultDic = data as! Dictionary<String,AnyObject>
            let  accessToken = resultDic["accessToken"]
            let  refreshToken = resultDic["refreshToken"]
            
            setAccessToken(token: accessToken as! String)
            setRefreshToken(token: refreshToken as! String)
            
            setUserInfo(info: resultDic["data"] as! Dictionary<String, Any>)
            
            let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            if getUserStatus() == .review_pass{
                sharedAppdelegate.window?.rootViewController = sharedAppdelegate.mainTabBarVc
            }else{
                let reply = CertifApplyController()
                let naviVC = UINavigationController(rootViewController: reply)
                sharedAppdelegate.window?.rootViewController = naviVC
            }
            
            
          
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        

    }
    
    @IBAction func registerAction(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @IBAction func resetpasswordAction(_ sender: Any) {
        let resetVC = ResetPasswordViewController()
        self.navigationController?.pushViewController(resetVC, animated: true)
    }
    
    
    func didTap(_ checkBox: BEMCheckBox) {
        self.passwordTextfield.isSecureTextEntry = !self.checkbox.on
    }
}
