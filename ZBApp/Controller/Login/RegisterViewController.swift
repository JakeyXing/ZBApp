//
//  RegisterViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import BEMCheckBox
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var areaCodeLabel: UILabel!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var vertyCodeTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBOutlet weak var checkbox: BEMCheckBox!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkbox.boxType = BEMBoxType.square
        self.checkbox.onFillColor = kTintColorYellow
        self.checkbox.onTintColor = kTintColorYellow
        self.checkbox.onCheckColor = UIColor.white
 
    }



}
