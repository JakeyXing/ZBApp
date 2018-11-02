//
//  CertifApplyController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import MBProgressHUD
import Toast
import ObjectMapper
import Toast
import MBProgressHUD

class CertifApplyController: UIViewController,JHNavigationBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var user: ZB_User?
    
    enum UploadImageType {
        case headIcon, certiPic, passPortPic
    }
    
    var userIconUrl = ""
    var certiPicUrl = ""
    var passPortPicUrl = ""
    
    var cameraPicker: UIImagePickerController!
    
    var uploadImageType = UploadImageType.headIcon
    
    
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "apply.nav.title")
        view.editButton.setTitle(LanguageHelper.getString(key: "apply.nav.submit"), for: .normal)
        view.editButton.setTitleColor(kTintColorYellow, for: .normal)
        view.delegate = self
        view.backButton.isHidden = true
        return view
    }()
    
     private lazy var otherStatusLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+1)
        return view
    }()
    
    lazy var headImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "defaultHear")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = kResizedPoint(pt: 24)
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(headImageViewTapped))
        img.addGestureRecognizer(tap1)
        return img
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.none
        textField.placeholder  = LanguageHelper.getString(key: "apply.item.name")
        textField.font = kFont(size: 15)
//        textField.keyboardType = UIKeyboardType.numberPad
//        textField.delegate = self
        return textField
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
    private lazy var secSegment: UISegmentedControl = {
        let view = UISegmentedControl(items: [LanguageHelper.getString(key: "apply.sex.man"),LanguageHelper.getString(key: "apply.sex.woman")])
        view.tintColor = kTintColorYellow
        view.selectedSegmentIndex = 0
        return view
    }()
    
    private lazy var nationLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "apply.item.nationty"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var cityLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "apply.item.city"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var dropdownView1: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = LanguageHelper.getString(key: "common.country.China")
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["common.country.China","common.country.Japan","common.country.Australia","common.country.Other"]
        return view
    }()
    
    private lazy var dropdownView2: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = ""
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = []
        return view
    }()
    
    private lazy var cerTypeLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "apply.item.cerType"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var dropdownView3: JHDropdownView = {
        let view = JHDropdownView(frame: CGRect.init())
        view.contentLabel.text = LanguageHelper.getString(key: "apply.cerType.passport")
        view.contentLabel.textColor = kFontColorBlack
        view.dataArray = ["apply.cerType.passport","apply.cerType.drLicence"]
        return view
    }()
    
    private lazy var cerNumTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        textField.borderStyle = UITextField.BorderStyle.none
        textField.placeholder  = LanguageHelper.getString(key: "apply.item.cerNo")
        textField.font = kFont(size: 15)
        //        textField.keyboardType = UIKeyboardType.numberPad
        //        textField.delegate = self
        return textField
    }()
    
    private lazy var lineView_2: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
    private lazy var cerPicLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "apply.item.uploadCerPic"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var cerPicImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cer_add_img")
        
        img.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(cerPicImageViewTapped))
        img.addGestureRecognizer(tap1)
        return img
    }()
    
    
    lazy var passPicImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cer_add_img")
        img.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(passPicImageViewTapped))
        img.addGestureRecognizer(tap1)
        return img
    }()
    
  
    
    private lazy var passportPicLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "apply.item.uploadPassportPic"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.scrollview)
        self.view.addSubview(self.otherStatusLabel)
        
        self.scrollview.addSubview(self.headImageView)
        self.scrollview.addSubview(self.nameTextField)
        self.scrollview.addSubview(self.lineView)
        self.scrollview.addSubview(self.secSegment)
        self.scrollview.addSubview(self.nationLabel)
        self.scrollview.addSubview(self.cityLabel)
        self.scrollview.addSubview(self.dropdownView1)
        self.scrollview.addSubview(self.dropdownView2)
        self.scrollview.addSubview(self.cerTypeLabel)
        self.scrollview.addSubview(self.dropdownView3)
        self.scrollview.addSubview(self.cerNumTextField)
        self.scrollview.addSubview(self.lineView_2)
        self.scrollview.addSubview(self.cerPicLabel)
        self.scrollview.addSubview(self.cerPicImageView)
        self.scrollview.addSubview(self.passportPicLabel)
        self.scrollview.addSubview(self.passPicImageView)
        
        self.subViewsLayout()
        
        self.loadData()
    }
    
    func loadData(){
        
        let params = [:] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .get, url: UserInfoUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
            
            let user = Mapper<ZB_User>().map(JSON: dic as! [String : Any])
            self.user = user
            self.configData()
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
        
        //city
        let params_1 = [:] as [String : Any]
        NetWorkManager.shared.loadRequest(method: .get, url: ApplyCityUrl, parameters: params_1 as [String : Any], success: { (data) in
         

            let resultDic = data as! Dictionary<String,AnyObject>
            let arr = resultDic["data"]
            if arr == nil {
                return
            }
            let citys:[String] = arr as! [String]
            
            self.dropdownView2.contentLabel.text = citys[0]
            self.dropdownView2.dataArray = citys
        
            
        }) { (data, errMsg) in
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    func configData() {
        if self.user?.userStatus == .registred {
            self.scrollview.isHidden = false
            self.otherStatusLabel.isHidden = true
        }else{
            self.scrollview.isHidden = true
            self.otherStatusLabel.isHidden = false
            
            if self.user?.userStatus == .review_wait{
       
                self.otherStatusLabel.text = LanguageHelper.getString(key: "login.apply.wait")
            }else{
                self.otherStatusLabel.text = LanguageHelper.getString(key: "login.apply.failed")
            }
            
        }
    }
    
    func subViewsLayout(){
        
        self.otherStatusLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.view.mas_centerY)
            make.centerX.equalTo()(self.view.mas_centerX)
        }
        
        //
        self.headImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.scrollview.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 48))
            make.height.equalTo()(kResizedPoint(pt: 48))
        }
        self.nameTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.headImageView.mas_centerY)
            make.left.equalTo()(self.headImageView.mas_right)?.offset()(kResizedPoint(pt: 15))
            make.width.equalTo()(kResizedPoint(pt: 260))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
       
        self.lineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nameTextField.mas_bottom)
            make.left.equalTo()(self.nameTextField.mas_left)
            make.right.equalTo()(self.nameTextField.mas_right)
            make.height.equalTo()(1)
        }
        
        self.secSegment.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.headImageView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.headImageView.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 80))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.nationLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.secSegment.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.headImageView.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cityLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.nationLabel.mas_centerY)
            make.left.equalTo()(self.nationLabel.mas_right)?.offset()(kResizedPoint(pt: 60))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.dropdownView1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nationLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.nationLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.dropdownView2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nationLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.cityLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        self.cerTypeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.dropdownView2.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.headImageView.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.dropdownView3.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerTypeLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.cerTypeLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 100))
            make.height.equalTo()(kResizedPoint(pt: 20))
        }
        
        
        self.cerNumTextField.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.dropdownView3.mas_centerY)
            make.left.equalTo()(self.dropdownView3.mas_right)?.offset()(kResizedPoint(pt: 15))
            make.width.equalTo()(kResizedPoint(pt: 210))
            make.height.equalTo()(kResizedPoint(pt: 30))
        }
        
        self.lineView_2.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerNumTextField.mas_bottom)
            make.left.equalTo()(self.cerNumTextField.mas_left)
            make.right.equalTo()(self.cerNumTextField.mas_right)
            make.height.equalTo()(1)
        }
        
        
        self.cerPicLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.dropdownView3.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.headImageView.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cerPicImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerPicLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.cerPicLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        self.passportPicLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerPicImageView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.headImageView.mas_left)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.passPicImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.passportPicLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.passportPicLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        
        
    }
    
    
    //MARK: - actions
    @objc private func passPicImageViewTapped(){
        uploadImageType = .passPortPic
        self.takePic()
        
    }
    
    @objc private func cerPicImageViewTapped(){
        uploadImageType = .certiPic
        self.takePic()
        
    }
    
    @objc private func headImageViewTapped(){
        uploadImageType = .headIcon
        self.takePic()
    }
    
    func takePic() {
        self.cameraPicker = UIImagePickerController()
        self.cameraPicker.delegate = self
        self.cameraPicker.sourceType = .camera
        
        self.present(self.cameraPicker, animated: true, completion: nil)
    }
    
    
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func rightAction() {
        //提交
 
        
        if self.nameTextField.text?.count == 0 {
            self.view.makeToast("name is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if userIconUrl == "" {
            self.view.makeToast("userIcon is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if self.cerNumTextField.text?.count == 0 {
            self.view.makeToast("ID Number is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if certiPicUrl == "" {
            self.view.makeToast("ID picture is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
        
        if passPortPicUrl == "" {
            self.view.makeToast("passport picture is nil", duration: 2, position: CSToastPositionCenter)
            return
            
        }
    
        var sex = ""
        if self.secSegment.selectedSegmentIndex == 0 {
            sex = LanguageHelper.getString(key: "apply.sex.man")
        }else{
            sex = LanguageHelper.getString(key: "apply.sex.woman")
        }
        
        
        let params = ["nationality": self.dropdownView1.contentLabel.text as Any,"sex": sex,"userImgUrl": userIconUrl,"userName": self.nameTextField.text as Any,"validNo": self.cerNumTextField.text as Any,"validNoImgUrl": certiPicUrl,"validType": self.dropdownView3.contentLabel.text as Any,"visaImgUrl": passPortPicUrl,"workCity": self.dropdownView2.contentLabel.text as Any] as [String : Any]
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetWorkManager.shared.loadRequest(method: .post, url: ApplyUrl, parameters: params as [String : Any], success: { (data) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            let resultDic = data as! Dictionary<String,AnyObject>
            let dic = resultDic["data"]
            if dic == nil {
                return
            }
            
            setUserStatus(status: dic?["userStatus"] as! String)
            let user = Mapper<ZB_User>().map(JSON: dic as! [String : Any])
            self.user = user
            self.configData()
            
        }) { (data, errMsg) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast(errMsg, duration: 2, position: CSToastPositionCenter)
            
            
        }
        
    }
    
    
    //MARK: - 相机代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
       
        switch uploadImageType {
        case .headIcon:
            
            let imgName = "userIcon_pic_" + CommonMethod.timestamp()
            
            let savedImagePath = CommonMethod.getImagePath(image, imageName: imgName)
            
            let fileNa = imgName + ".png"
            
            uploadDataToAWS(fileName: fileNa, filePath: savedImagePath!, success: { (url) in
                
                DispatchQueue.main.async(execute: {
                    self.headImageView.image = image
                    
                    self.userIconUrl = url ?? ""
                  
                })
                
            }) { (errMsg) in
                
            }
            
        case .certiPic:
            
            let imgName = "cer_pic_" + CommonMethod.timestamp()
            let savedImagePath = CommonMethod.getImagePath(image, imageName: imgName)
            let fileNa = imgName + ".png"
            uploadDataToAWS(fileName: fileNa, filePath: savedImagePath!, success: { (url) in
                
                DispatchQueue.main.async(execute: {
                    self.cerPicImageView.image = image
                    
                    self.certiPicUrl = url ?? ""
                    
                    self.cerPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
                        make.width.equalTo()(kResizedPoint(pt: 330))
                        make.height.equalTo()(kResizedPoint(pt: 330))
                    }
                    self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
                })
                
                
                
            }) { (errMsg) in
                self.view.makeToast("upload failed")
                
            }
            
            
            
        case .passPortPic:
            
            let imgName = "passport_pic_" + CommonMethod.timestamp()
            let savedImagePath = CommonMethod.getImagePath(image, imageName: imgName)
            let fileNa = imgName + ".png"
            uploadDataToAWS(fileName: fileNa, filePath: savedImagePath!, success: { (url) in
                
                DispatchQueue.main.async(execute: {
                    
                    self.passPicImageView.image = image
                    
                    self.passPortPicUrl = url ?? ""
                    
                    self.passPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
                        make.width.equalTo()(kResizedPoint(pt: 330))
                        make.height.equalTo()(kResizedPoint(pt: 330))
                    }
                    self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
                   
                })
                
                
            }) { (errMsg) in
                self.view.makeToast("upload failed")
                
            }
    
            
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
