//
//  JHListChooseView.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/10.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
private let  kListCellID = "kListCellID"

protocol JHListChooseViewDelegate: class {
    func listChooseViewDidClosed(_ listChooseView: JHListChooseView);
    func listChooseView(_ listChooseView: JHListChooseView,didSelectedIndex index: NSInteger);
}
class JHListChooseView: UIView {

    weak var delegate: JHListChooseViewDelegate?
    var typeArray : [String]? {
        didSet{
            let dateArray = typeArray
            if (dateArray != nil) {
                let tempH = CGFloat(kResizedPoint(pt: 45)) * CGFloat(dateArray?.count ?? 0)
                self.tabelBgView.frame = CGRect.init(x:kResizedPoint(pt: 20) , y: navigationBarHeight, width: kResizedPoint(pt: 100), height: kResizedPoint(pt: 30)+tempH)
                self.tableView.frame = CGRect.init(x: 0, y: kResizedPoint(pt: 15), width: kResizedPoint(pt: 100), height: kResizedPoint(pt: 5)+tempH)
            }
            self.tableView.reloadData()
        }
    }
    
    
    private lazy var tabelBgView: UIView = {
        let view = UIView(frame: CGRect.init(x:kResizedPoint(pt: 20) , y: navigationBarHeight, width: kResizedPoint(pt: 100), height: kResizedPoint(pt: 254)))
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = RGBCOLOR(r: 0, 0, 0).cgColor
        view.layer.shadowOffset = CGSize.init(width: 0, height: 2);
        view.layer.shadowRadius = kResizedPoint(pt: 6);
        view.layer.shadowOpacity = 0.15;
        view.layer.cornerRadius = kResizedPoint(pt: 5);
        view.layer.masksToBounds = false;
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.init(x: 0, y: kResizedPoint(pt: 15), width: kResizedPoint(pt: 100), height: kResizedPoint(pt: 254-15)), style: UITableView.Style.plain)
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.backgroundColor = UIColor.white
        table.showsVerticalScrollIndicator = false
        table.dataSource = self;
        table.delegate = self;
        table.register(ListChooseCell.self, forCellReuseIdentifier: kListCellID)
        
        let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: DEVICE_WIDTH, height: kResizedPoint(pt: 30)))
        footerView.backgroundColor = UIColor.clear
        table.tableFooterView = footerView
        
        return table
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
    @objc private func tapAction(){
        self.delegate?.listChooseViewDidClosed(self)
        
    }
    
}

extension JHListChooseView:UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataArray = typeArray else {
            return 0
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListChooseCell = tableView.dequeueReusableCell(withIdentifier: kListCellID, for: indexPath) as! ListChooseCell
        cell.itemLabel.text = self.typeArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kResizedPoint(pt: 45)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        self.delegate?.listChooseView(self, didSelectedIndex: indexPath.row)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let rusult = touch.view?.isDescendant(of: tabelBgView)

        if rusult! {
            return false
        }else{
           return true
        }
    }
    
}

extension JHListChooseView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = UIColor.clear
        self.addSubview(self.tabelBgView)
        self.tabelBgView.addSubview(self.tableView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.delegate = self;
        self.addGestureRecognizer(tap)
        
    }
    
    
}
