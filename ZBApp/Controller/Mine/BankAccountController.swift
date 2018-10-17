//
//  BankAccountController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
class BankAccountController: UIViewController,JHNavigationBarDelegate {

    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = "银行账户"
        view.delegate = self
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight)
        return view
    }()
    
    private lazy var seSegment: UISegmentedControl = {
        let view: UISegmentedControl = UISegmentedControl(items: ["当地银行账户","中国银行账户"])
        view.tintColor = kTintColorYellow
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(segChanged), for: UIControl.Event.valueChanged)
        return view
    }()
    
    private lazy var localBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var chinaBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    ///
    private lazy var hanNameLabel: UILabel = UILabel.cz_label(withText: "受取人名(汉字)", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var hanNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var riNameLabel: UILabel = UILabel.cz_label(withText: "受取人名(日文)", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var riNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var bankNameLabel: UILabel = UILabel.cz_label(withText: "银行名", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var bankNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var branchNameLabel: UILabel = UILabel.cz_label(withText: "支店名", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var branchNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var branchCodeLabel: UILabel = UILabel.cz_label(withText: "支店代码", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var branchCodeTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var fanCodeLabel: UILabel = UILabel.cz_label(withText: "口座番号", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var fanCodeTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var subjectDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = "东京"
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["东京","大阪","京都","北京","上海","广州","深圳"]
        return view
    }()
    
    private lazy var subjectLabel: UILabel = UILabel.cz_label(withText: "科目", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var accountBankLabel: UILabel = UILabel.cz_label(withText: "开户行", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var accountBankTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var bankUserLabel: UILabel = UILabel.cz_label(withText: "户名", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var bankUserTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var bankAccountLabel: UILabel = UILabel.cz_label(withText: "账号", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var bankAccountTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.placeholder  = ""
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    ////
    
    lazy var savedButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle("保存", for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.scrollview)
        
        self.scrollview.addSubview(self.seSegment)
        self.scrollview.addSubview(self.localBgView)
        self.scrollview.addSubview(self.chinaBgView)
        self.scrollview.addSubview(self.savedButton)
        self.localBgView.isHidden = false
        self.chinaBgView.isHidden = true
        
//        self.localBgView.backgroundColor = UIColor.gray
        self.chinaBgView.backgroundColor = UIColor.purple
        
        self.localBgView.addSubview(self.hanNameLabel)
        self.localBgView.addSubview(self.hanNameTextField)
        self.localBgView.addSubview(self.riNameLabel)
        self.localBgView.addSubview(self.riNameTextField)
        self.localBgView.addSubview(self.bankNameLabel)
        self.localBgView.addSubview(self.bankNameTextField)
        self.localBgView.addSubview(self.branchNameLabel)
        self.localBgView.addSubview(self.branchNameTextField)
        self.localBgView.addSubview(self.branchCodeLabel)
        self.localBgView.addSubview(self.branchCodeTextField)
        self.localBgView.addSubview(self.fanCodeLabel)
        self.localBgView.addSubview(self.fanCodeTextField)
        self.localBgView.addSubview(self.subjectLabel)
        self.localBgView.addSubview(self.subjectDropdownView)
        self.localBgView.addSubview(self.accountBankLabel)
        self.localBgView.addSubview(self.accountBankTextField)
        self.localBgView.addSubview(self.bankUserLabel)
        self.localBgView.addSubview(self.bankUserTextField)
        self.localBgView.addSubview(self.bankAccountLabel)
        self.localBgView.addSubview(self.bankAccountTextField)

        self.subViewsLayout()
    }
    
    
    func subViewsLayout(){
        
        self.seSegment.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.scrollview.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.centerX.equalTo()(self.view.mas_centerX)
            make.width.equalTo()(kResizedPoint(pt: 280))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.localBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.seSegment.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.right().equalTo()(self.view)
            make.height.equalTo()(kResizedPoint(pt: 421))
        }
        
        self.chinaBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.seSegment.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.right().equalTo()(self.view)
            make.height.equalTo()(kResizedPoint(pt: 300))
        }
        
        self.savedButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.localBgView.mas_bottom)?.offset()(kResizedPoint(pt: 40))
            make.width.equalTo()(kResizedPoint(pt: 280))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.hanNameTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.localBgView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.top.equalTo()(self.localBgView.mas_top)
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.hanNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.hanNameTextField.mas_centerY)
            make.right.equalTo()(self.hanNameTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.riNameTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.hanNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.riNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.riNameTextField.mas_centerY)
            make.right.equalTo()(self.riNameTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.bankNameTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.riNameTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.bankNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.bankNameTextField.mas_centerY)
            make.right.equalTo()(self.bankNameTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.branchNameTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.bankNameTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.branchNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.branchNameTextField.mas_centerY)
            make.right.equalTo()(self.branchNameTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.branchCodeTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.branchNameTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.branchCodeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.branchCodeTextField.mas_centerY)
            make.right.equalTo()(self.branchCodeTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.fanCodeTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.branchCodeTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.fanCodeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.fanCodeTextField.mas_centerY)
            make.right.equalTo()(self.fanCodeTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.subjectDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.hanNameTextField.mas_left)
            make.top.equalTo()(self.fanCodeTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.subjectLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.subjectDropdownView.mas_centerY)
            make.right.equalTo()(self.subjectDropdownView.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.accountBankTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.subjectDropdownView.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.accountBankLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.accountBankTextField.mas_centerY)
            make.right.equalTo()(self.accountBankTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.bankUserTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.accountBankTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.bankUserLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.bankUserTextField.mas_centerY)
            make.right.equalTo()(self.bankUserTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.bankAccountTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.hanNameTextField.mas_right)
            make.top.equalTo()(self.bankUserTextField.mas_bottom)?.offset()(kResizedPoint(pt: 16))
            make.width.equalTo()(kResizedPoint(pt: 220))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.bankAccountLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.bankAccountTextField.mas_centerY)
            make.right.equalTo()(self.bankAccountTextField.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        
    }
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightAction() {
        
    }
    
    @objc private func segChanged(seg: UISegmentedControl){
        if seg.selectedSegmentIndex == 0 {
            self.localBgView.isHidden = false
            self.chinaBgView.isHidden = true
            self.savedButton.mas_remakeConstraints { (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
                make.top.equalTo()(self.localBgView.mas_bottom)?.offset()(kResizedPoint(pt: 40))
                make.width.equalTo()(kResizedPoint(pt: 280))
                make.height.equalTo()(kResizedPoint(pt: 30))
            }
        }else{
            self.localBgView.isHidden = true
            self.chinaBgView.isHidden = false
            self.savedButton.mas_remakeConstraints { (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
                make.top.equalTo()(self.chinaBgView.mas_bottom)?.offset()(kResizedPoint(pt: 40))
                make.width.equalTo()(kResizedPoint(pt: 280))
                make.height.equalTo()(kResizedPoint(pt: 30))
            }
        }
      
    }
    
    @objc private func sureAction() {
 
        
    }
    
    

}
