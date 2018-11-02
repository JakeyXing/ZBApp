//
//  PersonalInfoController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/18.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry

class PersonalInfoController: UIViewController,JHNavigationBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var user: ZB_User?
    var cameraPicker: UIImagePickerController!
    
    private lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "personal.nav.title")
        view.delegate = self
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT-navigationBarHeight))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+1)
        return view
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let type = UILabel()
        type.font = kMediumFont(size: 16)
        type.textColor = kFontColorBlack;
        type.text = LanguageHelper.getString(key: "mine.btns.baseInfo")
        return type
    }()
    private lazy var infoLineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
    private lazy var nameTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.base.name"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var nameLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var sexTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.base.sex"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var sexLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var nationTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.base.natonalty"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var nationLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var cityTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.base.city"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var cityLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var cerTitleLabel: UILabel = {
        let type = UILabel()
        type.font = kMediumFont(size: 16)
        type.textColor = kFontColorBlack;
        type.text = LanguageHelper.getString(key: "personal.ideti.title")
        return type
    }()
    private lazy var cerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBgColorGray_221
        return view
    }()
    
    private lazy var cerTypeTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.ideti.idType"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var cerTypeLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var cerNumTitleLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.ideti.idNum"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    private lazy var cerNumLabel: UILabel = UILabel.cz_label(withText: "2356778900", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    private lazy var cerPicLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "personal.ideti.idPic"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var cerPicImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cer_add_img")
        
        img.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(cerPicImageViewTapped))
        img.addGestureRecognizer(tap1)
        return img
    }()
    
    private lazy var passportPicLabel: UILabel = UILabel.cz_label(withText: "签证图片:", fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    lazy var passPicImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cer_add_img")
        img.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(passPicImageViewTapped))
        img.addGestureRecognizer(tap1)
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.scrollview)
        
        self.scrollview.addSubview(self.infoTitleLabel)
        self.scrollview.addSubview(self.infoLineView)
        self.scrollview.addSubview(self.nameTitleLabel)
        self.scrollview.addSubview(self.nameLabel)
        self.scrollview.addSubview(self.sexTitleLabel)
        self.scrollview.addSubview(self.sexLabel)
        self.scrollview.addSubview(self.nationTitleLabel)
        self.scrollview.addSubview(self.nationLabel)
        self.scrollview.addSubview(self.cityTitleLabel)
        self.scrollview.addSubview(self.cityLabel)
        self.scrollview.addSubview(self.cerTitleLabel)
        self.scrollview.addSubview(self.cerLineView)
        self.scrollview.addSubview(self.cerTypeTitleLabel)
        self.scrollview.addSubview(self.cerTypeLabel)
        self.scrollview.addSubview(self.cerNumTitleLabel)
        self.scrollview.addSubview(self.cerNumLabel)
        self.scrollview.addSubview(self.cerPicLabel)
        self.scrollview.addSubview(self.cerPicImageView)
        self.scrollview.addSubview(self.passportPicLabel)
        self.scrollview.addSubview(self.passPicImageView)
        
        self.subViewsLayout()
        
        self.configData()
    }
    
    func configData() {
        self.nameLabel.text = self.user?.userName
        self.sexLabel.text = self.user?.sex
        self.nationLabel.text = self.user?.nationality
        self.cityLabel.text = self.user?.workCity
        
        self.cerTypeLabel.text = self.user?.validType
        self.cerNumLabel.text = self.user?.validNo
        
        if self.user?.visaImgUrl != nil {
            self.passPicImageView.sd_setImage(with: URL(fileURLWithPath: self.user?.visaImgUrl ?? ""), completed: nil)
            self.passPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
                make.width.equalTo()(kResizedPoint(pt: 330))
                make.height.equalTo()(kResizedPoint(pt: 330))
            }
            self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
            
        }
        
        if self.user?.validNoImgUrl != nil {
            self.cerPicImageView.sd_setImage(with: URL(fileURLWithPath: self.user?.validNoImgUrl ?? ""), completed: nil)
            self.cerPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
                make.width.equalTo()(kResizedPoint(pt: 330))
                make.height.equalTo()(kResizedPoint(pt: 330))
            }
            self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
            
            
        }
        
    }
    
    func subViewsLayout(){
        self.infoTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.scrollview.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
        }
        self.infoLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.infoTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 335))
            make.height.equalTo()(kResizedPoint(pt: 2))
        }
        
        self.nameTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.infoLineView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 40))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.nameTitleLabel.mas_centerY)
            make.left.equalTo()(self.nameTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        
        self.sexTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nameTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.sexLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.sexTitleLabel.mas_centerY)
            make.left.equalTo()(self.sexTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        
        self.nationTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.sexTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.nationLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.nationTitleLabel.mas_centerY)
            make.left.equalTo()(self.nationTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cityTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.nationTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cityLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.cityTitleLabel.mas_centerY)
            make.left.equalTo()(self.cityTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        
        self.cerTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cityTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 30))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
        }
        self.cerLineView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.scrollview.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.width.equalTo()(kResizedPoint(pt: 335))
            make.height.equalTo()(kResizedPoint(pt: 2))
        }
        
        self.cerTypeTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerLineView.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cerTypeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.cerTypeTitleLabel.mas_centerY)
            make.left.equalTo()(self.cerTypeTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cerNumTitleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerTypeTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cerNumLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.cerNumTitleLabel.mas_centerY)
            make.left.equalTo()(self.cerNumTitleLabel.mas_right)?.offset()(kResizedPoint(pt: 10))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.cerPicLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.cerNumTitleLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.nameTitleLabel.mas_right)
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
            make.right.equalTo()(self.nameTitleLabel.mas_right)
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.passPicImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.passportPicLabel.mas_bottom)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.cerPicLabel.mas_left)
            make.width.equalTo()(kResizedPoint(pt: 90))
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        
    }
    
    
    //MARK: - actions
    @objc private func passPicImageViewTapped(){
//        uploadImageType = .passPortPic
//        self.takePic()
        
    }
    
    @objc private func cerPicImageViewTapped(){
//        uploadImageType = .certiPic
//        self.takePic()
        
    }
    
    @objc private func headImageViewTapped(){
//        uploadImageType = .headIcon
//        self.takePic()
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
        
    }
    
    
    //MARK: - 相机代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
//        switch uploadImageType {
//        case .headIcon:
//            self.headImageView.image = image
//        case .certiPic:
//            self.cerPicImageView.image = image
//            self.cerPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
//                make.width.equalTo()(kResizedPoint(pt: 330))
//                make.height.equalTo()(kResizedPoint(pt: 330))
//            }
//            self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
//            
//        case .passPortPic:
//            self.passPicImageView.image = image
//            self.passPicImageView.mas_updateConstraints { (make:MASConstraintMaker!) in
//                make.width.equalTo()(kResizedPoint(pt: 330))
//                make.height.equalTo()(kResizedPoint(pt: 330))
//            }
//            self.scrollview.contentSize = CGSize.init(width: DEVICE_WIDTH, height: DEVICE_HEIGHT+kResizedPoint(pt: 450))
//        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
