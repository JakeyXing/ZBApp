//
//  HomeMissionCell.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/24.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class HomeMissionCell: UITableViewCell {
    //MARK: - 控件
    private var model: ZB_TaskInfo?
    private lazy var timeLabel: UILabel = UILabel.cz_label(withText: "2018-07-22", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    private lazy var priceLabel: UILabel = UILabel.cz_label(withText: "2300~3500", fontSize: kResizedFont(ft: 16), color: kTintColorYellow)
    
    private lazy var unitLabel: UILabel = UILabel.cz_label(withText: "JPY", fontSize: kResizedFont(ft: 16), color: kFontColorGray)
    
    private lazy var locaLabel: UILabel = UILabel.cz_label(withText: "", fontSize: 15, color: kFontColorGray)
    private lazy var roomNoLabel: UILabel = UILabel.cz_label(withText: "", fontSize: 15, color: kFontColorGray)
    

    lazy var addressIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        return img
    }()
    
    private lazy var requireLabel: UILabel = {
        let require = UILabel()
        require.font = kFont(size: 13)
        require.textColor = kFontColorGray;
        require.textAlignment = NSTextAlignment.right
        require.text = "完成任务，经检查合格且无客诉，可额外获得1300JPY"
        return require
    }()
    
    private lazy var typeLabel: UILabel = {
        let type = UILabel()
        type.font = kFont(size: 16)
        type.textColor = kFontColorGray_177;
        type.textAlignment = NSTextAlignment.center
        type.backgroundColor = UIColor.white
        type.text = ""
        return type
    }()
    
//    private lazy var numLabel: UILabel = UILabel.cz_label(withText: "8+1/10", fontSize: 14, color: kFontColorGray)
    
    private lazy var remainTimeLabel: UILabel = UILabel.cz_label(withText: "截止抢单时间剩余:", fontSize: 14, color: kFontColorGray)
    
    private lazy var bottomCapView: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
    //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = RGBCOLOR(r: 238, 235, 220)
        self.setUpUI()
        self.subViewsLayout()
    }
    
    
    //MARK: - private method
    func setUpData(model:ZB_TaskInfo) {
        let timeInterv = timeToTimeStamp(time: model.startDate!)
        
        self.model = model;
        self.timeLabel.text = timeStampToString(timeStamp: timeInterv)
        self.priceLabel.text = String(format: "%.1f", model.base)
        self.unitLabel.text = model.currency
        self.locaLabel.text = model.address?.name
        
        var proCount = 0
        proCount = self.model?.properties?.count ?? 0
        
        if (proCount > 0 && "CLEAN/MAINTAIN".contains(model.type!)){
            if proCount == 1{
                let taskProperty = self.model?.properties?[0]
                self.roomNoLabel.text = taskProperty?.doorplate
            }else{
                var plates: String = ""
                for i in 0..<proCount{
                    let taskProperty = self.model?.properties?[i]
                    plates.append(String(format: ",%@", taskProperty?.doorplate ?? ""))
                }
                self.roomNoLabel.text = plates
            }
        } else {
            roomNoLabel.isHidden = true
        }
        
        let bouns = String(format: "%.1f", model.bonus)
        let attributes = [NSAttributedString.Key.foregroundColor: kTintColorYellow]
        let attributedBouns = NSAttributedString(string: bouns, attributes: attributes)
        
        let attributedStr = NSMutableAttributedString()
        attributedStr.append(NSAttributedString(string: LanguageHelper.getString(key: "home.cell.bonus")))
        attributedStr.append(attributedBouns)
        attributedStr.append(NSAttributedString(string: model.currency!))
        
        //LanguageHelper.getString(key: "home.cell.bonus") + String(format: "%.1f", model.bonus) + model.currency!
        self.requireLabel.attributedText = attributedStr
        self.typeLabel.text = typeNameWithStr(str: model.type ?? "")
        self.remainTimeLabel.text = LanguageHelper.getString(key: "home.cell.remainTime") + getFormatRemainTime(secounds: timeInterv - 3600)
        
    }
    
    func setUpUI(){
        self.roomNoLabel.lineBreakMode = .byTruncatingMiddle
        self.locaLabel.lineBreakMode = .byTruncatingMiddle
        self.addSubview(timeLabel)
        self.addSubview(priceLabel)
        self.addSubview(unitLabel)
        self.addSubview(locaLabel)
        self.addSubview(roomNoLabel)
        self.addSubview(addressIcon)
        self.addSubview(requireLabel)
        self.addSubview(typeLabel)
//        self.addSubview(numLabel)
        self.addSubview(remainTimeLabel)
        self.addSubview(bottomCapView)
    }
    
    func subViewsLayout(){
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 20))
        }
        
        self.unitLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
        }
        
        self.priceLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.unitLabel.mas_left)?.offset()(kResizedPoint(pt: -3))
            make.centerY.equalTo()(self.timeLabel.mas_centerY)
        }
        
        self.addressIcon.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.top.equalTo()(self.unitLabel.mas_bottom)?.offset()(kResizedPoint(pt: 15))
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.locaLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.addressIcon.mas_left)?.offset()(kResizedPoint(pt: -5))
            make.centerY.equalTo()(self.addressIcon.mas_centerY)
            make.width.lessThanOrEqualTo()(kResizedPoint(pt: 200))
        }
        
        self.roomNoLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.timeLabel.mas_left);
            make.centerY.equalTo()(self.addressIcon.mas_centerY)
            make.width.lessThanOrEqualTo()(kResizedPoint(pt: 110))
        }
        
        self.requireLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.lessThanOrEqualTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.top.equalTo()(self.locaLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
        }
        
        self.typeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.top.equalTo()(self.requireLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.width.equalTo()(kResizedPoint(pt: 46))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
//        self.numLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.typeLabel.mas_right)?.offset()(kResizedPoint(pt: 90))
//            make.centerY.equalTo()(self.typeLabel.mas_centerY)
//        }
        
        self.remainTimeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.centerY.equalTo()(self.typeLabel.mas_centerY)
        }
        
        self.bottomCapView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.right()?.bottom().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 10))
        }
        
    }
    
    
}
