//
//  FeedbackListViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/23.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD
import Toast

private let  kFeedbackItemCell = "kFeedbackItemCell"
class FeedbackListViewController: UIViewController,JHNavigationBarDelegate {
    
    var taskLogs: [ZB_TaskLog]?
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.titleLabel.text = LanguageHelper.getString(key: "detail.log.pageTitle")
        return view
    }()

    var tableview:UITableView?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.setTableView()
    }
    
    func setTableView(){
        tableview = UITableView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight), style: UITableView.Style.plain)
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.backgroundColor = kBgColorGray_221
        tableview?.dataSource = self;
        tableview?.delegate = self;
        tableview?.register(FeedbackItemCell.self, forCellReuseIdentifier: kFeedbackItemCell)
        
        self.view.addSubview(tableview!);
        
    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }

    
}

extension FeedbackListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskLogs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeedbackItemCell = tableView.dequeueReusableCell(withIdentifier: kFeedbackItemCell, for: indexPath) as! FeedbackItemCell
        let log = self.taskLogs![indexPath.row]
        cell.congfigDataWithLog(model: log)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let log = self.taskLogs![indexPath.row]
        let h = self.cellHeightWithLog(log: log)
        return h
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        
        
    }
    
    
    
    
    func cellHeightWithLog(log: ZB_TaskLog) -> CGFloat {
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20)*2, height: CGFloat(HUGE))
        
        
        let fbH = UILabel.cz_labelHeight(withText: log.log_description, size: size, font: kFont(size: 15))
        let contentH = kResizedPoint(pt: 77)+fbH
        
        
        return contentH+kResizedPoint(pt: 5)
        
        
    }

    
}
