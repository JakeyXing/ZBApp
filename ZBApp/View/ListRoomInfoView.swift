//
//  ListRoomInfoView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/13.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

private let  kRoomRuteCellID = "kRoomRuteCellID"


protocol ListRoomInfoViewDelegate: class {
    func listRoomInfoViewDidTappedRoute(_ view: ListRoomInfoView, routeUrl routeUrlStr:String)
    func listRoomInfoViewDidTappedPassword(_ view: ListRoomInfoView, password passws:[ZB_PwdInfo])
    func listRoomInfoViewDidTappedUploadFeedback(_ view: ListRoomInfoView)
    
}
class ListRoomInfoView: UIView {
    weak var delegate: ListRoomInfoViewDelegate?
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = kBgColorGray_238_235_220
        return content
    }()
    private lazy var roomNumLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.roomNum"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var passwordTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.ksPassword"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var roadRuteLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.roomInfo.kShortRoute"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var tableview: UITableView = {
        let tablev = UITableView(frame: CGRect.init(), style: UITableView.Style.plain)
        tablev.separatorStyle = UITableViewCell.SeparatorStyle.none
        tablev.backgroundColor = RGBCOLOR(r: 229, 222, 196)
        tablev.isScrollEnabled = false
        tablev.dataSource = self;
        tablev.delegate = self;
        tablev.register(RoomRuteCell.self, forCellReuseIdentifier: kRoomRuteCellID)
        return tablev
    }()
    
    lazy var infoUploadButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.blue
        btn.setTitle(LanguageHelper.getString(key: "detail.roomInfo.uploadInfo"), for: .normal)
        btn.titleLabel?.font = kFont(size: 15)
        btn.addTarget(self, action: #selector(infoUploadAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    var roomArray: [ZB_TaskProperty]? {
        didSet{
            self.tableview.reloadData()
            self.congSubViewHeight()
            
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
    
    //MARK: - actions
    
    @objc private func infoUploadAction(){
        self.delegate?.listRoomInfoViewDidTappedUploadFeedback(self)
        
    }
    
    @objc private func routeAction(btn: UIButton){
        let index = btn.tag - 100
        let prop = self.roomArray?[index]
        
        self.delegate?.listRoomInfoViewDidTappedRoute(self, routeUrl: prop?.guideUrl ?? "")
        
    }
    
    @objc private func passwordAction(btn: UIButton){
        let index = btn.tag - 200
        let prop = self.roomArray?[index]
        
        self.delegate?.listRoomInfoViewDidTappedPassword(self, password: prop?.pwdInfos ?? [])
        
    }
    
    func congSubViewHeight() {

        let tabH = kResizedPoint(pt: 27)*CGFloat(self.roomArray?.count ?? 0)+kResizedPoint(pt: 10)
        
        self.tableview.mas_updateConstraints() { (make:MASConstraintMaker!) in
            make.height.equalTo()(tabH)
        }
        
        //10+17+10+h+10
        let contentH = kResizedPoint(pt: 47)+tabH
        
        self.contentView.mas_updateConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(contentH)
        }
        
        
    }
    
//    func congfigDataWithTask(info: ZB_Task){
//        self.roomArray = self.model?.properties
//       
//    }
    
    func viewHeight() -> CGFloat {
        let tabH = kResizedPoint(pt: 27)*CGFloat(self.roomArray?.count ?? 0)+kResizedPoint(pt: 10)
        self.tableview.mas_updateConstraints() { (make:MASConstraintMaker!) in
            make.height.equalTo()(tabH)
        }
        //10+17+10+h+10
        let contentH = kResizedPoint(pt: 47)+tabH
        return (contentH+kResizedPoint(pt: 36))
    }
    
    
}

extension ListRoomInfoView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        
        self.contentView.addSubview(self.roomNumLabel)
        self.contentView.addSubview(self.passwordTitleLabel)
        self.contentView.addSubview(self.roadRuteLabel)
        self.contentView.addSubview(self.tableview)
    
        self.addSubview(self.infoUploadButton)
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        self.roomNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 70))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.passwordTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.roomNumLabel.mas_centerY)
            make.left.equalTo()(self.roomNumLabel.mas_right)?.offset()(kResizedPoint(pt: 70))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.roadRuteLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.roomNumLabel.mas_centerY)
            make.left.equalTo()(self.passwordTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.tableview.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.roomNumLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.contentView.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.height.equalTo()(kResizedPoint(pt: 60))
        }
     
        self.infoUploadButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: 0))
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 26))
        }
        
        
        
    }
    
}

extension ListRoomInfoView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoomRuteCell = tableView.dequeueReusableCell(withIdentifier: kRoomRuteCellID, for: indexPath) as! RoomRuteCell
        let prop = self.roomArray?[indexPath.row]
        cell.configData(model: prop!)
        cell.routeButton.tag = 100 + indexPath.row
        cell.routeButton.addTarget(self, action: #selector(routeAction(btn:)), for: UIControl.Event.touchUpInside)
        
        cell.passwordButton.tag = 200 + indexPath.row
        cell.passwordButton.addTarget(self, action: #selector(passwordAction(btn:)), for: UIControl.Event.touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kResizedPoint(pt: 17+10)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
    }
    
}
