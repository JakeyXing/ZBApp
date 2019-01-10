//
//  PasswordCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/31.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class PasswordCell: UITableViewCell {
    //MARK: - 控件
    var model:ZB_PwdInfo?
    
    lazy var titleLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var desLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var bgView: UIView = {
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
        self.backgroundColor = UIColor.white//RGBCOLOR(r: 238, 235, 220)
        self.setUpUI()
        self.subViewsLayout()
    }
    
    
    //MARK: - private method
  
    func setUpUI(){
        self.titleLabel.numberOfLines = 0
        self.desLabel.numberOfLines = 0
        
        self.addSubview(bgView)
        self.bgView.addSubview(titleLabel)
        self.bgView.addSubview(desLabel)
        
   
    }
    
    func setupData(mode:ZB_PwdInfo) {
        
        self.model = mode
        let type:String = model?.type ?? ""
        self.titleLabel.text = LanguageHelper.getString(key: ("detail.roomPassword." + type.lowercased()))//
//        self.desLabel.text = mode.desc
//        let attrStr = NSAttributedString(string: mode.desc ?? "", attributes: [NSAttributedString.Key:])
//        NSDocumentTypeDocumentAttribute
//        NSHTMLTextDocumentType
//        let attrStr = NSAttributedString(string: mode.desc ?? "", attributes: [NSAttributedString.DocumentAttributeKey.documentType : NSAttributedString.DocumentType.html])
        let att = try? NSAttributedString(data: mode.desc?.data(using: String.Encoding.unicode) ?? "".data(using: String.Encoding.unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
//        desLabel.attributedText = attrStr
        desLabel.attributedText = att
        
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 10)*2-kResizedPoint(pt: 15), height: CGFloat(HUGE))
        
        let titleH = UILabel.cz_labelHeight(withText: self.titleLabel.text, size: size, font: self.titleLabel.font)
        let desH = UILabel.cz_labelHeight(withText: self.desLabel.text, size: size, font: self.desLabel.font)
        
        let bgH = kResizedPoint(pt: 5+10+5) + titleH + desH
        
        self.bgView.mas_updateConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(bgH)
        }
    }
    
    func subViewsLayout(){
        self.bgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -10))
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 60))
        }
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.bgView.mas_top)?.offset()(kResizedPoint(pt: 5))
            make.left.equalTo()(self.bgView.mas_left)?.offset()(kResizedPoint(pt: 5))
            make.right.equalTo()(self.bgView.mas_right)?.offset()(kResizedPoint(pt: -10))
            
        }
        
        self.desLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.bgView.mas_left)?.offset()(kResizedPoint(pt: 5))
            make.right.equalTo()(self.bgView.mas_right)?.offset()(kResizedPoint(pt: -10))
        }
        
      
        
       
        
        
        
        
    }
    
    
}
