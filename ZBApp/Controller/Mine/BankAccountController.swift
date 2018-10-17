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
        
        self.view.addSubview(self.seSegment)
        self.view.addSubview(self.localBgView)
        self.view.addSubview(self.chinaBgView)
        self.view.addSubview(self.savedButton)
        self.localBgView.isHidden = false
        self.chinaBgView.isHidden = true
        
        self.subViewsLayout()
    }
    
    
    func subViewsLayout(){
        
        self.seSegment.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.navigationBar.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.centerX.equalTo()(self.view.mas_centerX)
            make.width.equalTo()(kResizedPoint(pt: 280))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.localBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.seSegment.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.right().equalTo()(self.view)
            make.height.equalTo()(kResizedPoint(pt: 200))
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
