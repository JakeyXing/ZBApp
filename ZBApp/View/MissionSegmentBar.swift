//
//  MissionSegmentBar.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/18.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

protocol MissionSegmentBarDelegate: class {
    func missionSegmentBar(_ segmentBar: MissionSegmentBar,didSelectedIndex index: NSInteger)

}

class MissionSegmentBar: UIView {
    //MARK: - delegate
    weak var delegate: MissionSegmentBarDelegate?
    
    var titleArr:[String]!
    let btnW = kResizedPoint(pt: 50)
    let btnH = kResizedPoint(pt: 40)
    var lastSelectedBtn: UIButton?
    
    
    //MARK: - 控件
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.clear
        return content
    }()

    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - actions
    @objc private func btnAction(btn: UIButton){
        self.delegate?.missionSegmentBar(self, didSelectedIndex: btn.tag - 100)
        if (lastSelectedBtn != nil && lastSelectedBtn != btn) {
            lastSelectedBtn!.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        }
        
        btn.setTitleColor(kTintColorYellow, for: UIControl.State.normal)
        
        lastSelectedBtn = btn
    }
    

}

extension MissionSegmentBar{
    
    //MARK: - private methods
    
    func initView(){
        titleArr = ["待开始","进行中","已完成","已取消"]
    
        var left = kResizedPoint(pt: 26)
        
        let btnSpace = (DEVICE_WIDTH - CGFloat(titleArr.count) * btnW - left * 2)/CGFloat(titleArr.count - 1)
        
        let count = titleArr.count
     
        for i in 0..<count {
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
            btn.titleLabel?.font = kFont(size: 15)
            btn.setTitle(titleArr[i], for: .normal)
            btn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
            btn.tag = 100 + i
            
            btn.frame = CGRect.init(x: left, y: kResizedPoint(pt: 2), width: btnW, height: btnH)
            self.addSubview(btn)
            left = left + (btnW + btnSpace)
            
        }
     
    }
    

    
}
