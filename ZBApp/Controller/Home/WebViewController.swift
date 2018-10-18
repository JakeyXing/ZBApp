//
//  WebViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/18.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var titleStr: String?
    var urlStr: String?
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.backButton.isHidden = true
        return view
    }()
    
    private lazy var webview: UIWebView = {
        let view = UIWebView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.scalesPageToFit = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.webview)
        
        self.navigationBar.titleLabel.text = self.titleStr;
        self.webview.loadRequest(URLRequest.init(url: URL.init(string: self.urlStr!)!))

    }


}
