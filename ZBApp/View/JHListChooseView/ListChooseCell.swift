//
//  ListChooseCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/10.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
class ListChooseCell: UITableViewCell {
    //MARK: - 控件
    lazy var itemLabel: UILabel = UILabel.cz_label(withText: "lalla", fontSize: kResizedFont(ft: 14), color: kFontColorGray)
    
    //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.addSubview(itemLabel)
        self.itemLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 10))
            make.centerY.equalTo()(self.mas_centerY)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
