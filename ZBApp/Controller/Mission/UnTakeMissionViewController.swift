//
//  UnTakeMissionViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import BEMCheckBox
private let  kMissionCellID = "kMissionCellID"
class UnTakeMissionViewController: UIViewController {
    
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.backButton.isHidden = true
        return view
    }()
    
    private lazy var typeSegment: MissionSegmentBar = {
        let view = MissionSegmentBar(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: 44))
        return view
    }()
    
    private lazy var topBarBg: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: kResizedPoint(pt: 40)))
        return view
    }()
    
    private lazy var typeDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = "全部类型"
        view.contentLabel.textColor = kFontColorBlack
        view.contentLabel.font = kFont(size: 15)
        view.dataArray = ["全部类型","摆场","撤场","维修","清扫"]
        return view
    }()
    
    lazy var timeButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setTitle("任务日期", for: .normal)
        btn.addTarget(self, action: #selector(timeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var checkBox: BEMCheckBox = {
        let box = BEMCheckBox()
        box.boxType = BEMBoxType.square
        box.onFillColor = kTintColorYellow
        box.onTintColor = kTintColorYellow
        box.onCheckColor = UIColor.white
        return box
    }()
    
     private lazy var onlyuselessLabel: UILabel = UILabel.cz_label(withText: "仅无效订单", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    
    var tableview:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.navigationBar.contentView.addSubview(self.typeSegment)
        self.view.addSubview(self.topBarBg)
        
        self.topBarBg.addSubview(self.typeDropdownView)
        self.topBarBg.addSubview(self.timeButton)
        self.topBarBg.addSubview(self.onlyuselessLabel)
        self.topBarBg.addSubview(self.checkBox)
        self.setTableView()
        
        self.typeDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.topBarBg.mas_left)?.offset()(kResizedPoint(pt: 30))
            make.centerY.equalTo()(self.topBarBg.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 28))
        }
        
        self.timeButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.topBarBg.mas_centerY)
            make.left.equalTo()(self.typeDropdownView.mas_right)?.offset()(kResizedPoint(pt: 15))
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.onlyuselessLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.topBarBg.mas_right)?.offset()(kResizedPoint(pt: -30))
            make.centerY.equalTo()(self.topBarBg.mas_centerY)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.checkBox.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self.onlyuselessLabel.mas_left)?.offset()(kResizedPoint(pt: -10))
            make.centerY.equalTo()(self.topBarBg.mas_centerY)
            make.width.equalTo()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
    }
    
    func setTableView(){
        tableview = UITableView(frame: CGRect.init(x: 0, y: self.topBarBg.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight-kResizedPoint(pt: 40)), style: UITableView.Style.plain)
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.backgroundColor = kBgColorGray_221
        tableview?.dataSource = self;
        tableview?.delegate = self;
        tableview?.register(MissionCell.self, forCellReuseIdentifier: kMissionCellID)
        self.view.addSubview(tableview!);
    }
    
    
    //MARK: - actions
    @objc private func timeAction(){
        let calendarBg = CalendarBgView(frame: CGRect.init())
        calendarBg.delegate = self;
        UIApplication.shared.keyWindow?.addSubview(calendarBg)
        
    }
    
    
}

extension UnTakeMissionViewController:UITableViewDelegate,UITableViewDataSource,CalendarBgViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMissionCellID, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kResizedPoint(pt: 160)
    }
    
    func calendarDidChoosedDate(choosedDate: Date) {
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: choosedDate))
        
        self.timeButton.setTitle(formatter.string(from: choosedDate), for: .normal)
    }
    
}
