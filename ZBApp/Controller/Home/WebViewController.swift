//
//  WebViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/18.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import MBProgressHUD
class WebViewController: UIViewController,JHNavigationBarDelegate,UIWebViewDelegate {

    var titleStr: String?
    var urlStr: String?
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.delegate = self
        return view
    }()
    
    private lazy var webview: UIWebView = {
        let view = UIWebView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.scalesPageToFit = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.webview)
        
        self.navigationBar.titleLabel.text = self.titleStr;
        
        guard (self.urlStr != nil) else {
            print("urlStr 为空")
            return
        }
        
        guard (self.urlStr?.count ?? 0 > 0) else {
            print("urlStr 为空")
            return
        }
        
        let urlStr = self.urlStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.webview.loadRequest(URLRequest.init(url: URL.init(string: urlStr!)!))

    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
         MBProgressHUD.hide(for: self.view, animated: true)
    }


}
