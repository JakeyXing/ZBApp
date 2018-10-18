//
//  RepairImageCell.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/15.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

enum UploadMediaType {
    case image, video
}

protocol RepairImageCellDelegate: class {
    func repairImageCell(_ cell: RepairImageCell,didClosedAtIndexPath indexPath: IndexPath);

}
class RepairImageCell: UICollectionViewCell {
    
    var mediaType = UploadMediaType.image
    
    var indexpath: NSIndexPath!
    weak var delegate: RepairImageCellDelegate?
    
    //MARK: - 控件
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "addImage")
        return img
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let back = UIButton(type: UIButton.ButtonType.custom)
        back.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        back.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return back
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
    
    //MARK: - actions
    @objc private func closeAction(){
        self.delegate?.repairImageCell(self, didClosedAtIndexPath: self.indexpath as IndexPath)
        
    }
    
    
    //MARK: - private method
    func setUpUI(){
        self.addSubview(imageView)
        self.addSubview(closeButton)
        self.addSubview(progressView)
    }
    
    func subViewsLayout(){
        self.imageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        self.closeButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.imageView.mas_right)?.offset()(kResizedPoint(pt: 6))
            make.top.equalTo()(self.imageView.mas_top)?.offset()(kResizedPoint(pt: -4))
            make.width.equalTo()(kResizedPoint(pt: 35))
            make.height.equalTo()(kResizedPoint(pt: 32))
        }
        
        self.progressView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.imageView.mas_bottom)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 15))
        }

        
        
        
        
    }
    
    
}
