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
        
//        urlStr = "https://s3-ap-northeast-1.amazonaws.com/ostay-clean/product/%25E5%25A4%25A7%25E5%25AE%25AB%25E6%2588%25BF%25E9%2597%25B4%25E5%258F%25B7+%2526+%25E6%2588%25BF%25E9%2597%25A8%25E5%25AF%2586%25E7%25A0%2581_29.xlsx"
        var urlStr = self.urlStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        urlStr = urlStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        urlStr = urlStr?.replacingOccurrences(of: "%2520", with: "+")
        urlStr = urlStr?.replacingOccurrences(of: "&", with: "%2526")
        self.webview.loadRequest(URLRequest.init(url: URL.init(string: urlStr!)!))

    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        MBProgressHUD.showAdded(to: self.webview, animated: true)
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.webview, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
         MBProgressHUD.hide(for: webview, animated: true)
    }


}
