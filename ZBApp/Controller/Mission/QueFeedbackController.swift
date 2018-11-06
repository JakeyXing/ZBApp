//
//  QueFeedbackController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import MBProgressHUD
import Toast

class QueFeedbackController: UIViewController,JHNavigationBarDelegate,FeedbackImageUploadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

    var cameraPicker: UIImagePickerController!
    var currentIndex: NSInteger?
    
    var mID:Int64 = 0
    var type: String!
    
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "detail.feedbackUpload.pageTitle")
        view.delegate = self
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 40))
        return view
    }()
    
    private lazy var nameLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.feedbackUpload.des"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var infoTextView: UITextView = {
        let text = UITextView(frame: CGRect.init())
        text.layer.cornerRadius = 3
        text.layer.borderColor = kFontColorGray.cgColor
        text.layer.borderWidth = 0.5
        return text
        
    }()
    
    private lazy var typeLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.feedbackUpload.typeTitle"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var typeLabelDropdownView: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = LanguageHelper.getString(key: "detail.cleanFeedbackType.cantCleanUp")
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["detail.cleanFeedbackType.cantCleanUp","detail.cleanFeedbackType.equipmentNotWork","detail.cleanFeedbackType.furnitureDamaged","detail.cleanFeedbackType.changeGoods","detail.cleanFeedbackType.thingsLeftByCustomer","detail.cleanFeedbackType.notCheckin"]
        return view
    }()
    
    lazy var uploadView: FeedbackImageUploadView = {
        let view:FeedbackImageUploadView = FeedbackImageUploadView(frame: CGRect.init(x: 0, y: self.typeLabel.bottom+kResizedPoint(pt: 10), width: DEVICE_WIDTH, height: kResizedPoint(pt: 200)))
        view.delegate = self
        return view
    }()

    
    lazy var submitButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = kTintColorYellow
        btn.setTitle(LanguageHelper.getString(key: "common.btnTitle.sure"), for: .normal)
        btn.titleLabel?.font = kFont(size: 16)
        btn.addTarget(self, action: #selector(sureAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.scrollview)
        self.scrollview.addSubview(self.nameLabel)
        self.scrollview.addSubview(self.infoTextView)
        self.scrollview.addSubview(self.typeLabel)
        self.scrollview.addSubview(self.typeLabelDropdownView)
        self.scrollview.addSubview(self.uploadView)
        self.scrollview.addSubview(self.submitButton)
        
        self.uploadView.height = self.uploadView.height
        
        if self.type == "CLEAN" {
            self.typeLabel.isHidden = false
            self.typeLabelDropdownView.isHidden = false
        }else{
            self.typeLabelDropdownView.isHidden = true
            self.typeLabel.isHidden = true
        }
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.scrollview.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.infoTextView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 335))
            make.height.equalTo()(kResizedPoint(pt: 150))
        }
        
        self.typeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.infoTextView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.nameLabel.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.typeLabelDropdownView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.typeLabel.mas_centerY)
            make.left.equalTo()(self.typeLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.width.equalTo()(kResizedPoint(pt: 150))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        
        self.uploadView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.typeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.scrollview.mas_left)
            make.width.equalTo()(DEVICE_WIDTH)
            make.height.equalTo()(kResizedPoint(pt: 200))
        }
        
        
        self.submitButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.top.equalTo()(self.uploadView.mas_bottom)?.offset()(kResizedPoint(pt: 40))
            make.width.equalTo()(kResizedPoint(pt: 280))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
    }
    

    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightAction() {
        
    }
    
    //MARK: - actions
    @objc private func sureAction(){
        if self.infoTextView.text?.count == 0 {
            self.view.makeToast("description is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        let desc:String = self.infoTextView.text!
        
        var cleanType = ""
        if self.type == "CLEAN"{
            cleanType = self.typeLabelDropdownView.contentLabel.text!
        }
        let params = ["id":self.mID,"description":desc,"imgs":self.uploadView.imagesArray ?? [],"type":cleanType] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .post, url: ReportTaskQuesUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
        
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
   
        
    }
    
    
    
    //MARK:- FeedbackImageUploadViewDelegate
    func feedbackImageUploadView(_ view: FeedbackImageUploadView, didSelectedAtIndex index: NSInteger) {
        currentIndex = index
        
        self.cameraPicker = UIImagePickerController()
        self.cameraPicker.delegate = self
        self.cameraPicker.sourceType = .camera
        
        self.present(self.cameraPicker, animated: true, completion: nil)
    }
    
    func feedbackImageUploadViewDidUplaodSuccess(_ view: FeedbackImageUploadView) {
        self.uploadView.mas_updateConstraints { (make:MASConstraintMaker!) in
            
            make.height.equalTo()(self.uploadView.viewHeight())
        }
        
    }
    
    
    //MARK: - 相机代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.uploadView.addAndUploadImage(img: image, atIndexPath: currentIndex ?? 0)
        
    
        self.uploadView.mas_updateConstraints { (make:MASConstraintMaker!) in
       
            make.height.equalTo()(self.uploadView.viewHeight())
        }
        
        self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+self.uploadView.viewHeight())
        
        
        self.dismiss(animated: true, completion: nil)
    }

}
