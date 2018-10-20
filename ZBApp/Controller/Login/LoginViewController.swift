//
//  LoginViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import BEMCheckBox
class LoginViewController: UIViewController {

    @IBOutlet weak var areaCodeLabel: UILabel!
    
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
    }

    @IBAction func loginAction(_ sender: Any) {
        let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        sharedAppdelegate.window?.rootViewController = sharedAppdelegate.mainTabBarVc
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @IBAction func resetpasswordAction(_ sender: Any) {
        let resetVC = ResetPasswordViewController()
        self.navigationController?.pushViewController(resetVC, animated: true)
    }
}
