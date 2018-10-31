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
        self.checkbox.boxType = BEMBoxType.square
        self.checkbox.onFillColor = kTintColorYellow
        self.checkbox.onTintColor = kTintColorYellow
        self.checkbox.onCheckColor = UIColor.white
        self.checkbox.delegate = self
        
        self.areaDropdownView.contentLabel.text = "+86"
        self.areaDropdownView.contentLabel.textColor = kFontColorBlack
        self.areaDropdownView.dataArray = ["+86","+81"]
        self.areaDropdownView.extraTop = 0
    }

    @IBAction func loginAction(_ sender: Any) {
        if self.phoneTextfield.text?.count == 0 {
            self.view.makeToast("请输入手机号", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if self.passwordTextfield.text?.count == 0 {
            self.view.makeToast("请输入密码", duration: 2, position: CSToastPositionCenter)
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
