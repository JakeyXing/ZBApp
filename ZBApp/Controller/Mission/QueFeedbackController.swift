//
//  QueFeedbackController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
class QueFeedbackController: UIViewController,JHNavigationBarDelegate {

    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = "问题反馈"
        view.delegate = self
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight)
        return view
    }()
    
    private lazy var nameLabel: UILabel = UILabel.cz_label(withText: "问题上报", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var infoTextView: UITextView = {
        let text = UITextView(frame: CGRect.init())
        text.layer.cornerRadius = 3
        text.layer.borderColor = kFontColorGray.cgColor
        text.layer.borderWidth = 0.5
        return text
        
    }()
    
    private lazy var typeLabel: UILabel = UILabel.cz_label(withText: "类型:", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var typeLabelDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = "中国"
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["中国","日本"]
        return view
    }()
    
    
    lazy var submitButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle("确定", for: .normal)
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
        self.scrollview.addSubview(self.nameLabel)
        self.scrollview.addSubview(self.infoTextView)
        self.scrollview.addSubview(self.typeLabel)
        self.scrollview.addSubview(self.typeLabelDropdownView)
        self.scrollview.addSubview(self.submitButton)
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.scrollview.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.infoTextView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 335))
            make.height.equalTo()(kResizedPoint(pt: 150))
        }
        
        self.typeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.infoTextView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.nameLabel.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.typeLabelDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.typeLabel.mas_centerY)
            make.left.equalTo()(self.typeLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        
        self.submitButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.typeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 40))
            make.width.equalTo()(kResizedPoint(pt: 280))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
    }
    

    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightAction() {
        
    }
    
    //MARK: - actions
    @objc private func sureAction(){
   
        
    }

}