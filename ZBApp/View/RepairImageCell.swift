//
//  RepairImageCell.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/15.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class RepairImageCell: UICollectionViewCell {
    //MARK: - 控件
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "dePic")
        return img
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
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
        self.addSubview(imageView)
        self.addSubview(progressView)
    }
    
    func subViewsLayout(){
        self.imageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        self.progressView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.imageView.mas_bottom)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 10))
        }

        
        
        
        
    }
    
    
}
