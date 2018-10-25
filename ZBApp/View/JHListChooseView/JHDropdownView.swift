//
//  JHDropdownView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

protocol JHDropdownViewDelegate: class {
    func dropdownView(_ dropdownView: JHDropdownView,didSelectedString selectedStr: String)
}
extension JHDropdownViewDelegate {
    func dropdownView(_ dropdownView: JHDropdownView,didSelectedString selectedStr: String){
        print("ccccc")
    }
}

class JHDropdownView: UIView,JHListChooseViewDelegate {
    //MARK: - delegate
    weak var delegate: JHDropdownViewDelegate?
    var dataArray : [String]!
        
    var extraTop = navigationBarHeight
    lazy var typeListView: JHListChooseView = {
        let view = JHListChooseView(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT))
        view.delegate = self
        
        return view
    }()
    
    private lazy var iconImageView: UIImageView = UIImageView(image: UIImage(named:"school_icon01"))
    
    //MARK: - 控件
    lazy var contentLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 16), color: kFontColorGray)

    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
    }
    
    func initView() {
        self.backgroundColor = UIColor.white
        self.addSubview(iconImageView)
        self.addSubview(contentLabel)
        
        self.iconImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: 2))
            make.width.equalTo()(kResizedPoint(pt: 9))
            make.height.equalTo()(kResizedPoint(pt: 6))
        }
        
        self.contentLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self)?.offset()(kResizedPoint(pt: 2))
            make.right.equalTo()(self.iconImageView.mas_right)?.offset()(kResizedPoint(pt: -1))
            make.height.equalTo()(30)
        }
        
        self.contentLabel.isUserInteractionEnabled = true
        self.iconImageView.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(contentTapped))
        self.contentLabel.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.iconImageView.addGestureRecognizer(tap2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    override func awakeFromNib() {
        self.initView()
    }
    
    //MARK: - actions
    
    @objc private func contentTapped(){
        self.showMenu()
    }
    
    @objc private func imageTapped(){
        self.showMenu()
    }
    
    func showMenu(){
        self.typeListView.typeArray = self.dataArray
        
        self.typeListView.configOrigin(origin: CGPoint.init(x: self.frame.origin.x, y: self.bottom+extraTop))
        UIApplication.shared.keyWindow?.addSubview(self.typeListView)
    }
    
    //MARK: - JHListChooseViewDelegate
    func listChooseViewDidClosed(_ listChooseView: JHListChooseView) {
        
        self.typeListView.removeFromSuperview()
        
    }
    
    func listChooseView(_ listChooseView: JHListChooseView, didSelectedIndex index: NSInteger) {
        self.delegate?.dropdownView(self, didSelectedString: self.dataArray[index])
        self.contentLabel.text = LanguageHelper.getString(key: self.dataArray[index])
        self.typeListView.removeFromSuperview()
    }
    
}

