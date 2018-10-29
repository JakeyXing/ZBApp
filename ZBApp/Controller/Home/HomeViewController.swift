//
//  MyMissionViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/9/30.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD
import Toast
import  

private let  kHomeMissionCell = "kHomeMissionCell"
class HomeViewController: UIViewController {
    
    var selectedDate = ""
    var selectedType = ""
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.backButton.isHidden = true
        return view
    }()
    
    private lazy var typeSelectBar: MissionTypeTopBar = {
        let view = MissionTypeTopBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.taskTypeDropdownView.delegate = self
        view.delegate = self
        return view
    }()
    
    var tableview:UITableView?
    
    lazy var taskList = [ZB_TaskInfo]()
    var pagendex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.navigationBar.contentView.addSubview(self.typeSelectBar)
        self.setTableView()
        
        self.loadNewData()
    }
    
    func setTableView(){
        tableview = UITableView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight-tabbarHeight), style: UITableView.Style.plain)
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.backgroundColor = kBgColorGray_221
        tableview?.dataSource = self;
        tableview?.delegate = self;
        tableview?.register(HomeMissionCell.self, forCellReuseIdentifier: kHomeMissionCell)
        
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
        
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .get, url: PendingTaskListUrl, parameters: params as [String : Any], success: { (data) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            self.taskList.removeAll()
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            
            
            let array = [ZB_TaskInfo].deserialize(from: list)
            print(array)
//            guard let array = (NSArray.yy_modelArray(with: ZB_TaskInfo.self, json: (list ?? []))) as? [ZB_TaskInfo] else{
//                return
//            }
           
            
//            self.taskList.append(contentsOf: <#T##Sequence#>)
            self.tableview?.reloadData()
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    @objc private func refreshData(){
        pagendex = 1
        self.tableview?.mj_footer.state = MJRefreshState.idle
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex] as [String : Any]
        
        NetWorkManager.shared.loadRequest(method: .get, url: PendingTaskListUrl, parameters: params as [String : Any], success: { (data) in
            self.tableview?.mj_header.endRefreshing()
            
            self.taskList.removeAll()
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            guard let array = (NSArray.yy_modelArray(with: ZB_TaskInfo.self, json: (list ?? []))) as? [ZB_TaskInfo] else{
                return
            }
            self.taskList.append(contentsOf: array)
            self.tableview?.reloadData()
            
            
        }) { (data, errMsg) in
            self.tableview?.mj_header.endRefreshing()
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
        
    }
    
    @objc private func loadMoreData(){
        
        pagendex  += 1
        
        let params = ["taskDate":selectedDate,"taskType":selectedType,"page":pagendex] as [String : Any]
        
        NetWorkManager.shared.loadRequest(method: .get, url: PendingTaskListUrl, parameters: params as [String : Any], success: { (data) in
            
            self.tableview?.mj_footer.endRefreshing()
          
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"] as! Dictionary<String,AnyObject>
            let list = dic["list"]
            guard let array = (NSArray.yy_modelArray(with: ZB_TaskInfo.self, json: (list ?? []))) as? [ZB_TaskInfo] else{
                return
            }
            self.taskList.append(contentsOf: array)
            self.tableview?.reloadData()
            
        }) { (data, errMsg) in
            self.tableview?.mj_footer.endRefreshing()
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource,JHDropdownViewDelegate,MissionTypeTopBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
//        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeMissionCell = tableView.dequeueReusableCell(withIdentifier: kHomeMissionCell, for: indexPath) as! HomeMissionCell
        let model = self.taskList[indexPath.row]
        cell.setUpData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kResizedPoint(pt: 160)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let infoModel = self.taskList[indexPath.row]
        switch infoModel.type {
        case "LAUNCH","DISMANTLE":
            let carry = CarryMissionDetailViewController()
            carry.isTaked = false
            carry.model = infoModel
            carry.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(carry, animated: true)

        case "MAINTAIN":
            let repair = RepairMissionDetailViewController()
            repair.isTaked = false
            repair.model = infoModel
            repair.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(repair, animated: true)
        case "CLEAN":
            let clean = CleanMissionDetailViewController()
            clean.isTaked = false
            clean.model = infoModel
            clean.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(clean, animated: true)
        default:
            print("未知类型")
        }
        
//        if indexPath.row == 0 {
//            let carry = CarryMissionDetailViewController()
//            carry.isTaked = false
////            carry.model = infoModel
//            carry.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(carry, animated: true)
//
//        }else if indexPath.row == 1{
//            let clean = CleanMissionDetailViewController()
//            clean.isTaked = false
////            clean.model = infoModel
//            clean.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(clean, animated: true)
//        }else if indexPath.row == 2{
//            let repair = RepairMissionDetailViewController()
//            repair.isTaked = false
////            repair.model = infoModel
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
    
    func missionTypeTopBar(_ topBar: MissionTypeTopBar, didSelectedDate date: Date) {
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
//        print(formatter.string(from: date))
        selectedDate = formatter.string(from: date)
        
        
        self.loadNewData()
    }
    
    
}
