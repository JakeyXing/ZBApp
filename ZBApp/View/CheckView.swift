//
//  CheckView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry


/// 摆场、撤场审核结果显示部分check result
protocol CheckViewDelegate: class {
    func checkView(_ view: CheckView,didSelectedImageAtIndex index: NSInteger)
    
}
class CheckView: UIView {
    weak var delegate: CheckViewDelegate?
    
    lazy var titleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.check.title"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kFont(size: 15)
        lab.text = ""
        lab.numberOfLines = 0
        return lab
        
    }()
    
    lazy var picBgView:UIView = UIView()
    
    var imageTotalH :CGFloat = 0
    
    var imageArray : [String]? {
        didSet{
            let dateArray = imageArray
            if (dateArray != nil) {
                self.addImages()
            }else{
                self.picBgView.removeAllSubviews()
                imageTotalH = 0;
                self.picBgView.mas_updateConstraints { (make:MASConstraintMaker!) in
                    make.height.equalTo()(imageTotalH)
                }
            }
            
            
        }
    }
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congfigDataWithTask(model: ZB_Task) {
        self.imageArray = model.imgs
        
    }
    
    
    func viewHeight() -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        let h = UILabel.cz_labelHeight(withText: self.contentLabel.text, size: size, font: self.contentLabel.font)
        
        //17+10+h
        return h+kResizedPoint(pt: 27)+imageTotalH
    }
    
    
}

extension CheckView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.picBgView)
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.contentLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.titleLabel.mas_left)
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
        }
        
        self.picBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 40))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
    }
    
    func addImages() {
        self.picBgView.removeAllSubviews()
        
        let count = self.imageArray!.count
        let width:CGFloat = 98
        let cap:CGFloat = 8
        for i in 0..<count {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect.init(x: 0, y: 0, width: kResizedPoint(pt: width), height: kResizedPoint(pt: width))
            self.picBgView.addSubview(btn)
            btn.tag = 100 + i
            
            btn.left = CGFloat(i%3)*kResizedPoint(pt: width+cap)
            btn.top = CGFloat(i/3)*kResizedPoint(pt: width+cap)
            
            guard let urlString = self.imageArray?[i],
                let url = URL(string: urlString) else {
                    return
            }
            
            btn.sd_setImage(with: url, for: .normal, completed: nil)
            btn.addTarget(self, action: #selector(tappedImageAction), for: UIControl.Event.touchUpInside)
        }
        
        let nex = count%3
        var h = CGFloat(count/3)*kResizedPoint(pt: width+cap)+kResizedPoint(pt: width)
        
        if nex == 0 {
            h = CGFloat(count/3)*kResizedPoint(pt: width+cap)-kResizedPoint(pt: cap)
        } else{
            h = CGFloat(count/3)*kResizedPoint(pt: width+cap)+kResizedPoint(pt: width)
        }
        
        imageTotalH = h
        
        self.picBgView.mas_updateConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(h)
        }
        
    }
    
    @objc private func tappedImageAction(btn: UIButton){
        let index = btn.tag - 100
        self.delegate?.checkView(self, didSelectedImageAtIndex: index)
        
        
    }
    
}
