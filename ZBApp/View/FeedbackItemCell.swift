//
//  FeedbackItemCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/23.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class FeedbackItemCell: UITableViewCell {
    //MARK: - 控件
    private lazy var rizhiLabel: UILabel = {
        let require = UILabel()
        require.font = kFont(size: 13)
        require.textColor = kFontColorGray;
        require.textAlignment = NSTextAlignment.right
        require.text = "日志呀日志呀日志呀日志呀日志呀日志呀"
        return require
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
        self.addSubview(rizhiLabel)
 
    }
    
    func subViewsLayout(){
        self.rizhiLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.centerY.equalTo()(self.mas_centerY)?.offset()(kResizedPoint(pt: 0))
        }


    }
    
    
}
