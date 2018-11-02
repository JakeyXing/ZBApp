//
//  CalendarBgView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/11.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
protocol CalendarBgViewDelegate: class {
    func calendarDidChoosedDate(choosedDate: Date);
}
class CalendarBgView: UIView {

    weak var delegate: CalendarBgViewDelegate?
    
    private lazy var bgView: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = kResizedPoint(pt: 5)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = RGBCOLOR(r: 46, 46, 46)
        lab.textAlignment = NSTextAlignment.center
        lab.font = kFont(size: 16)
        lab.text = LanguageHelper.getString(key: "home.navi.time")
        return lab
        
    }()
    
    private lazy var cancelButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kTintColorYellow, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setTitle(LanguageHelper.getString(key: "detail.repairUploadAction.cancel"), for:  UIControl.State.normal)
        btn.addTarget(self, action: #selector(cancelAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var sureButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kTintColorYellow, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setTitle(LanguageHelper.getString(key: "common.btnTitle.sure"), for:  UIControl.State.normal)
        btn.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var datePicker: UIDatePicker! = {
        let datePicker = UIDatePicker()
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged),for: .valueChanged)
        return datePicker;
    
    }()

    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT))
        
        self.backgroundColor = RGBACOLOR(r: 0, 0, 0, 0.7)
        self.addSubview(bgView)
        self.bgView.addSubview(titleLabel)
        self.bgView.addSubview(datePicker)
        self.bgView.addSubview(cancelButton)
        self.bgView.addSubview(sureButton)
        
        self.bgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.centerY.equalTo()(self.mas_centerY)
            make.width.equalTo()( DEVICE_WIDTH-kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.bgView.mas_left)?.offset()(kResizedPoint(pt: 15))
            make.top.equalTo()(self.bgView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 10))
        }
        
        self.datePicker.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.bgView.mas_left)?.offset()(kResizedPoint(pt: 15))
            make.right.equalTo()(self.bgView.mas_right)?.offset()(kResizedPoint(pt: -15))
            make.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 105))
        }
        
        self.cancelButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.bgView.mas_left)
            make.right.equalTo()(self.sureButton.mas_left)
            make.top.equalTo()(self.datePicker.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.bottom.equalTo()(self.bgView.mas_bottom)?.offset()(kResizedPoint(pt: -15))
        }
        
        self.sureButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.bgView.mas_right)
            make.centerY.equalTo()(self.cancelButton.mas_centerY)
            make.width.equalTo()(self.cancelButton.mas_width)
            make.height.equalTo()(self.cancelButton.mas_height)
        }
        
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - actions
    @objc private func cancelAction(){

        self.removeFromSuperview()
        
    }
    
    @objc private func sureAction(){
        self.delegate?.calendarDidChoosedDate(choosedDate: datePicker.date)
         self.removeFromSuperview()
        
    }
    
    @objc private func dateChanged(datePicker:UIDatePicker){
        
        
        
    }
    
  
    
}

