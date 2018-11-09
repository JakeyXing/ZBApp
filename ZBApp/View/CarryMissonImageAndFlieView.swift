//
//  CarryMissonImageAndFlieView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.


import UIKit
import Masonry
import SDWebImage

protocol CarryMissonImageAndFlieViewDelegate: class {
    func carryMissonImageAndFlieView(_ view: CarryMissonImageAndFlieView,didSelectedImageAtIndex index: NSInteger)
    func carryMissonImageAndFlieView(_ view: CarryMissonImageAndFlieView,didSelectedFileAtIndex index: NSInteger)
    
}
class CarryMissonImageAndFlieView: UIView {
    
    weak var delegate: CarryMissonImageAndFlieViewDelegate?
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    
    lazy var picNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kMediumFont(size: 15)
        lab.text = LanguageHelper.getString(key: "detail.statusInfo.imgs")
        return lab
        
    }()
    
    lazy var picBgView:UIView = UIView()
    
    lazy var fileNameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
        lab.font = kMediumFont(size: 15)
        lab.text = LanguageHelper.getString(key: "detail.statusInfo.documents")
        return lab
        
    }()
    
    lazy var fileBgView:UIView = UIView()
    
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
    
    var fileArray : [String]? {
        didSet{
            let dateArray = fileArray
            if (dateArray != nil) {
                self.addfiles()
            }else{
                self.fileBgView.removeAllSubviews()
                fileTotalH = 0;
                self.fileBgView.mas_updateConstraints { (make:MASConstraintMaker!) in
                    make.height.equalTo()(fileTotalH)
                }
            }
            
        }
    }
  
    var imageTotalH :CGFloat = 0
    var fileTotalH :CGFloat = 0
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewHeight() -> CGFloat {
        //10+17+10+img+10+17+10+file+6
        return kResizedPoint(pt: 80)+imageTotalH+fileTotalH
    }
    
    
}

extension CarryMissonImageAndFlieView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.picNameLabel)
        self.contentView.addSubview(self.picBgView)
        self.contentView.addSubview(self.fileNameLabel)
        self.contentView.addSubview(self.fileBgView)
        
//        picBgView.backgroundColor = UIColor.red
//        fileBgView.backgroundColor = UIColor.red
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.bottom.equalTo()(self.mas_bottom)
        }
        
        self.picNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.picBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.picNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 40))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.fileNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.picBgView.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.fileBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.fileNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 40))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
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
    
    func addfiles() {
        self.fileBgView.removeAllSubviews()
        
        let count = self.fileArray!.count
        let width:CGFloat = 98
        let height:CGFloat = 98+2+36
        let cap:CGFloat = 8
        for i in 0..<count {
            let flieItem = FlieItem(frame: CGRect.init(x: 0, y: 0, width: kResizedPoint(pt: width), height: kResizedPoint(pt: height)))
            self.fileBgView.addSubview(flieItem)
            flieItem.addTarget(self, action: #selector(tappedFileAction), for: UIControl.Event.touchUpInside)
            flieItem.tag = 200 + i
            flieItem.left = CGFloat(i%3)*kResizedPoint(pt: width+cap)
            flieItem.top = CGFloat(i/3)*kResizedPoint(pt: height+cap)
            
            guard let urlString = self.fileArray?[i],
                let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    return
            }

            flieItem.fielImageView.image = UIImage(named: self.fileIconWithUrl(url: urlStr))
            flieItem.fileNameLabel.text = self.fileNameWithUrl(url: urlString)
            flieItem.addTarget(self, action: #selector(tappedFileAction), for: UIControl.Event.touchUpInside)
            
        }
        
        
        let nex = count%3
        var h = CGFloat(count/3)*kResizedPoint(pt: height+cap)+kResizedPoint(pt: height)
        
        if nex == 0 {
            h = CGFloat(count/3)*kResizedPoint(pt: height+cap)-kResizedPoint(pt: cap)
        } else{
            h = CGFloat(count/3)*kResizedPoint(pt: height+cap)+kResizedPoint(pt: height)
        }
        
        fileTotalH = h
        self.fileBgView.mas_updateConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(h)
        }
        
    }
    
    
    //MARK: - actions
    @objc private func tappedFileAction(item: FlieItem){
        let index = item.tag - 200
        self.delegate?.carryMissonImageAndFlieView(self, didSelectedFileAtIndex: index)
   
        
    }
    
    @objc private func tappedImageAction(btn: UIButton){
        let index = btn.tag - 100
        self.delegate?.carryMissonImageAndFlieView(self, didSelectedImageAtIndex: index)
        
        
    }
    
    func fileIconWithUrl(url:String) -> String {
        var iconImageName = ""
        if url.hasSuffix("pdf") {
            iconImageName = "pdf_icon"
            
        }else if url.hasSuffix("PDF") {
            iconImageName = "pdf_icon"
            
        }else if url.hasSuffix("docx") {
            iconImageName = "docx_icon"
            
        }else if url.hasSuffix("xlsx") {
            iconImageName = "xlsx_icon"
            
        }
        return iconImageName
        
    }
    
    func fileNameWithUrl(url:String) -> String {
        var fileName:String = ""
        let arr = url.split(separator: "/")
        print(arr)
        
        fileName = String(arr[arr.count-1])
        return fileName
        
    }
    
    
    
    
}
