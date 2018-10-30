//
//  StarView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/9.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class StarView: UIView {
    //MARK: - 控件
    lazy var levelLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setUpUI()
        self.subViewsLayout()
    }
    
    
    
    
    //MARK: - private method
    func setUpUI(){
        self.addSubview(levelLabel)
    }
    
    func subViewsLayout(){
        self.levelLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.right.equalTo()(self.mas_right)
        }
    }
    
    
}
