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
        view.backgroundColor = kTintColorYellow
        return view
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
        
        self.backgroundColor = RGBACOLOR(r: 0, 0, 0, 0.3)
        self.addSubview(bgView)
        self.bgView.addSubview(datePicker)
        
        self.bgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.centerY.equalTo()(self.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 350))
            make.height.equalTo()(kResizedPoint(pt: 246))
        }
        
        self.datePicker.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.bgView.mas_centerX)
            make.centerY.equalTo()(self.bgView.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 320))
            make.height.equalTo()(kResizedPoint(pt: 216))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dateChanged(datePicker:UIDatePicker){
        
        self.delegate?.calendarDidChoosedDate(choosedDate: datePicker.date)
        
    }
    
  
    
}

