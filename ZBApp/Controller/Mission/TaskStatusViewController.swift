//
//  TaskStatusViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/24.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import BEMCheckBox
import MJRefresh
import MBProgressHUD
import Toast
import ObjectMapper

private let  kMissionCellID = "kMissionCellID"
class TaskStatusViewController: UIViewController {
    
    var selectedDate = ""
    var selectedType = ""
    var onlyInValid = false
    
    var settedType:String!
   
    private lazy var topBarBg: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: kResizedPoint(pt: 40)))
        return view
    }()
    
    private lazy var typeDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = LanguageHelper.getString(key: "home.dropDwon.all")
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["home.dropDwon.all","home.dropDwon.launch","home.dropDwon.dismantle","home.dropDwon.maintain","home.dropDwon.clean"]
        view.extraTop = statusBarHeight
        view.delegate = self
        return view
    }()
    
    lazy var timeButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(kFontColorGray, for: UIControl.State.normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.setTitle(LanguageHelper.getString(key: "mission.select.time"), for: .normal)
        btn.addTarget(self, action: #selector(timeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var cleanDateButton: UIButton = {
        let back = UIButton(type: UIButton.ButtonType.custom)
        back.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        back.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return back
    }()
    
    lazy var checkBox: BEMCheckBox = {
        let box = BEMCheckBox()
        box.boxType = BEMBoxType.square
        box.onFillColor = kTintColorYellow
        box.onTintColor = kTintColorYellow
        box.onCheckColor = UIColor.white
        box.delegate = self
        return box
    }()
    
    private lazy var onlyuselessLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "mission.select.invalid"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    var pagendex = 1
    
    lazy var taskList = [ZB_Task]()
    
    var tableview:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.topBarBg)
        
        self.topBarBg.addSubview(self.typeDropdownView)
        self.topBarBg.addSubview(self.timeButton)
        self.topBarBg.addSubview(self.onlyuselessLabel)
        self.topBarBg.addSubview(self.cleanDateButton)
        self.topBarBg.addSubview(self.checkBox)
        self.cleanDateButton.isHidden = true
        self.checkBox.isHidden = true
        self.onlyuselessLabel.isHidden = true
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
        
        self.cleanDateButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.topBarBg.mas_centerY)
            make.left.equalTo()(self.timeButton.mas_right)?.offset()(kResizedPoint(pt: 2))
            make.width.equalTo()(kResizedPoint(pt: 35))
            make.height.equalTo()(kResizedPoint(pt: 32))
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
        
        self.loadNewData()
    }
    
    func setTableView(){
        tableview = UITableView(frame: CGRect.init(x: 0, y: self.topBarBg.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight-kResizedPoint(pt: 40)), style: UITableView.Style.plain)
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.backgroundColor = kBgColorGray_221
        tableview?.dataSource = self;
        tableview?.delegate = self;
        tableview?.register(MissionCell.self, forCellReuseIdentifier: kMissionCellID)
        self.view.addSubview(tableview!);
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableview?.mj_header = header
        
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        tableview?.mj_footer = footer
        
        self.view.addSubview(tableview!);
    }
    
    func loadNewData() {
        
        pagendex = 1
        
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex,"taskProgress":self.settedType] as [String : Any]
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .get, url: ExecuteTaskListUrl, parameters: params as [String : Any], success: { (data) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            self.taskList.removeAll()
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            let array: [ZB_Task] =  Mapper<ZB_Task>().mapArray(JSONArray: list as! [[String : Any]])
            self.taskList.append(contentsOf: array)
            self.tableview?.reloadData()
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    @objc private func refreshData(){
        pagendex = 1
        self.tableview?.mj_footer.state = MJRefreshState.idle
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex,"taskProgress":self.settedType] as [String : Any]
        
        NetWorkManager.shared.loadRequest(method: .get, url: ExecuteTaskListUrl, parameters: params as [String : Any], success: { (data) in
            self.tableview?.mj_header.endRefreshing()
            
            self.taskList.removeAll()
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            let array: [ZB_Task] =  Mapper<ZB_Task>().mapArray(JSONArray: list as! [[String : Any]])
            self.taskList.append(contentsOf: array)
            self.tableview?.reloadData()
            
            
        }) { (data, errMsg) in
            self.tableview?.mj_header.endRefreshing()
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
        
    }
    
    @objc private func loadMoreData(){
        
        pagendex  += 1
        
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex,"taskProgress":self.settedType] as [String : Any]
        
        NetWorkManager.shared.loadRequest(method: .get, url: ExecuteTaskListUrl, parameters: params as [String : Any], success: { (data) in
            
            self.tableview?.mj_footer.endRefreshing()
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            let array: [ZB_Task] =  Mapper<ZB_Task>().mapArray(JSONArray: list as! [[String : Any]])
            self.taskList.append(contentsOf: array)
            self.tableview?.reloadData()
            
        }) { (data, errMsg) in
            self.tableview?.mj_footer.endRefreshing()
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    
    //MARK: - actions
    @objc private func timeAction(){
        let calendarBg = CalendarBgView(frame: CGRect.init())
        calendarBg.delegate = self;
        UIApplication.shared.keyWindow?.addSubview(calendarBg)
        
    }
    @objc private func closeAction(){
        self.cleanDateButton.isHidden = true
        self.timeButton.setTitle(LanguageHelper.getString(key: "mission.select.time"), for: .normal)
        selectedDate = ""
        
        self.loadNewData()
        
    }
    
}

extension TaskStatusViewController:UITableViewDelegate,UITableViewDataSource,CalendarBgViewDelegate,JHDropdownViewDelegate,BEMCheckBoxDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MissionCell = tableView.dequeueReusableCell(withIdentifier: kMissionCellID, for: indexPath) as! MissionCell
        let model = self.taskList[indexPath.row]
        cell.setUpData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kResizedPoint(pt: 160)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let model = self.taskList[indexPath.row]
        switch model.type {
        case "LAUNCH","WITHDRAWAL":
            let carry = CarryMissionDetailViewController()
            carry.isTaked = true
            carry.taskExecuteId = model.id
            carry.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(carry, animated: true)

        case "MAINTAIN":
            let repair = RepairMissionDetailViewController()
            repair.isTaked = true
            repair.taskExecuteId = model.id
            repair.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(repair, animated: true)
        case "CLEAN":
            let clean = CleanMissionDetailViewController()
            clean.isTaked = true
            clean.taskExecuteId = model.id
            clean.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(clean, animated: true)
        default:
            print("未知类型")
        }
        
        
//        if indexPath.row == 0 {
//            let carry = CarryMissionDetailViewController()
//            carry.isTaked = true
////            carry.taskExecuteId = model.id
//            carry.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(carry, animated: true)
//
//        }else if indexPath.row == 1{
//            let clean = CleanMissionDetailViewController()
//            clean.isTaked = true
//            clean.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(clean, animated: true)
//        }else if indexPath.row == 2{
//            let repair = RepairMissionDetailViewController()
//            repair.isTaked = true
//            repair.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(repair, animated: true)
//
//        }
        
    }
    
    //MARK: - JHDropdownViewDelegate
    func dropdownView(_ dropdownView: JHDropdownView, didSelectedString selectedStr: String) {
        
        selectedType = configTypeParamWithStr(typeStr: selectedStr)
        
        self.loadNewData()
        
    }
    //MARK: - calendar
    func calendarDidChoosedDate(choosedDate: Date) {
        self.cleanDateButton.isHidden = false
        
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: choosedDate))
        
        self.timeButton.setTitle(formatter.string(from: choosedDate), for: .normal)
        
        selectedDate = formatter.string(from: choosedDate)
        
        self.loadNewData()
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        //        onlyInValid = self.checkBox.on
        //        self.loadNewData()
    }
    
}
