//
//  RegisterViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/12.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var areaCodeLabel: UILabel!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var vertyCodeTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var showPasswordSwitch: UISwitch!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPasswordSwitch.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
