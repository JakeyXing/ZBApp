//
//  FeedbackItemCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/23.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

protocol FeedbackItemCellDelegate: class {
    func feedbackItemCell(_ cell: FeedbackItemCell,lookoverImages images: Array<String>)
    
}

class FeedbackItemCell: UITableViewCell {
    //MARK: - 控件
    weak var delegate: FeedbackItemCellDelegate?
    
    private lazy var reasonL: UILabel = {
        let require = UILabel()
        require.font = kFont(size: 13)
        require.textColor = kFontColorGray;
        require.textAlignment = NSTextAlignment.right
        require.text = "aaaaaaaaaa"
        require.textAlignment = .left
        return require
    }()
    
    var model: ZB_Task?
    var log : ZB_TaskLog?
    lazy var contentBgView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
    lazy var timeLabel: UILabel = UILabel.cz_label(withText: "2018-09-12 12:09:12", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var feebackLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = "反馈-海外网10月12日电当地时间10月12日，2018年“新学院奖”在瑞典斯德哥尔摩公共图书馆揭晓，玛丽斯·孔戴(Maryse Condé)获得此奖项"
        lab.numberOfLines = 0
        return lab
        
    }()
    
    lazy var picButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(RGBCOLOR(r: 254, 0, 5), for: UIControl.State.normal)
        btn.setTitle(LanguageHelper.getString(key: "detail.feedback.morePic"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(picAction), for: UIControl.Event.touchUpInside)
        return btn
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
    func setUpUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentBgView)
        self.contentBgView.addSubview(self.timeLabel)
        self.contentBgView.addSubview(self.feebackLabel)
        contentBgView.addSubview(reasonL)
        self.contentBgView.addSubview(self.picButton)
        
        self.subViewsLayout()
 
    }
    
    func subViewsLayout(){
        
        self.contentBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentBgView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentBgView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.feebackLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.timeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.timeLabel.mas_left)
            make.right.equalTo()(self.contentBgView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        reasonL.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.feebackLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.timeLabel.mas_left)
            make.right.equalTo()(self.contentBgView.mas_right)?.offset()(kResizedPoint(pt: -20))
        }

        self.picButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.reasonL.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.contentBgView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.width.equalTo()(kResizedPoint(pt: 70))
            make.height.equalTo()(kResizedPoint(pt: 20))
            
        }
        
    }
    
    func congfigDataWithLog(model: ZB_TaskLog){
    
        log = model
        let imgCount = log?.imgs?.count ?? 0
        
        self.timeLabel.text = log?.date
        self.feebackLabel.text = log?.log_description
        reasonL.text = log?.reason
        
        self.congfigSubViewHeight()
        
        if imgCount > 0{
            self.picButton.isHidden = false
        }else{
            self.picButton.isHidden = true
        }
        
    }
    
    //MARK: - actions
    @objc private func picAction(){
//        let cout = self.model?.taskLogs?.count ?? 0
        let cout = log?.imgs?.count
        if cout == 0 {
            return
        }
        
//        let log = self.model?.taskLogs![0]
        
        self.delegate?.feedbackItemCell(self, lookoverImages: log?.imgs ?? [""])
        
    }
    
    func congfigSubViewHeight() {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        let fbH = UILabel.cz_labelHeight(withText: self.feebackLabel.text, size: size, font: self.feebackLabel.font)
        //10+17+10+h+10+20+10
        let contentH = kResizedPoint(pt: 77)+fbH
        self.contentBgView.mas_updateConstraints{ (make:MASConstraintMaker!) in
            make.height.equalTo()(contentH)
        }
    }
    
    
}
