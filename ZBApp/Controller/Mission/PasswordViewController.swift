//
//  PasswordViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/26.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController,JHNavigationBarDelegate {
    
    var titleStr: String?
    var passArr: [ZB_PwdInfo]?
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.delegate = self
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        
        self.titleStr = "201"
        self.navigationBar.titleLabel.text = self.titleStr;

        
    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
