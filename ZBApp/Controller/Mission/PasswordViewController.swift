//
//  PasswordViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/26.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit

private let  kPasswordCellID = "kPasswordCellID"
class PasswordViewController: UIViewController,JHNavigationBarDelegate {
    
    var titleStr: String?
    var passArr: [ZB_PwdInfo]?
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.delegate = self
        return view
    }()
    var tableview:UITableView?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        
        self.titleStr = LanguageHelper.getString(key: "detail.password.pageTitle")
        self.navigationBar.titleLabel.text = self.titleStr;
        
        self.setTableView()

        
    }
    
    func setTableView(){
        tableview = UITableView(frame: CGRect.init(x: 0, y: self.navigationBar.bottom, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight), style: UITableView.Style.plain)
        tableview?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview?.backgroundColor = UIColor.white
        tableview?.dataSource = self;
        tableview?.delegate = self;
        tableview?.register(PasswordCell.self, forCellReuseIdentifier: kPasswordCellID)
        self.view.addSubview(tableview!);
    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension PasswordViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passArr?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PasswordCell = tableView.dequeueReusableCell(withIdentifier: kPasswordCellID, for: indexPath) as! PasswordCell
        let model:ZB_PwdInfo = self.passArr![indexPath.row]
        cell.setupData(mode: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let size = CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 10)*2-kResizedPoint(pt: 15), height: CGFloat(HUGE))
        let model:ZB_PwdInfo = self.passArr![indexPath.row]
        let titleH = UILabel.cz_labelHeight(withText: model.type, size: size, font: kFont(size: 15))
        let desH = UILabel.cz_labelHeight(withText: model.desc, size: size, font: kFont(size: 15))
        
        let bgH = kResizedPoint(pt: 5+10+5) + titleH + desH
        
    
        return kResizedPoint(pt: 20) + bgH
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
       
    }
    
   
    
}

