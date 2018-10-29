//
//  CleanImageCell.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/15.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import AWSCore
import AWSS3

protocol CleanImageCellDelegate: class {
    func cleanImageCell(_ cell: CleanImageCell,imageUploadSucceed imageUrl: String,atIndex indexPath:IndexPath)
    
    func cleanImageCell(_ cell: CleanImageCell,imageUploadFailedIndex indexPath:IndexPath)
    
}
class CleanImageCell: UICollectionViewCell {
    weak var delegate: CleanImageCellDelegate?
    
    //MARK: - 图片相关
    var oriImage: UIImage?
    var savedImagePath: String?
    var uploadedImageUrl: String?
    
    
    var indexpath: IndexPath!
    
    
    //MARK: - 控件
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "dePic")
        return img
    }()
    
    lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = kFontColorGray
//        lab.backgroundColor = kBgColorGray_238_235_220
        lab.textAlignment = NSTextAlignment.left
        lab.font = kFont(size: 15)
        lab.text = "左侧床-1左侧床-1"
        lab.numberOfLines = 2
        lab.lineBreakMode = .byTruncatingMiddle
        return lab
        
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    //MARK: - lifeCyele
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setUpUI()
        self.subViewsLayout()
    }
    
    //MARK: - private method
    func setUpUI(){
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(progressView)
    }
    
    func subViewsLayout(){
        self.imageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 90))
        }
        
        self.progressView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.imageView.mas_bottom)?.offset()(kResizedPoint(pt: 0))
            make.left.right().equalTo()(self)
            make.height.equalTo()(kResizedPoint(pt: 10))
        }
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.progressView.mas_bottom)?.offset()(kResizedPoint(pt: 2))
            make.left.right().equalTo()(self)
        }
        
    }
    
    func uploadImage(img:UIImage) {
        self.imageView.image = img
        self.oriImage = img
        let imgName = "clen_pic_" + CommonMethod.timestamp()
        
        self.savedImagePath = CommonMethod.getImagePath(img, imageName: imgName)
        self.uploadData(fileName: imgName)
        
    }
    
    func uploadData(fileName: String) {
        var data = Data()
        do {
            try data =  Data(contentsOf: URL(fileURLWithPath: self.savedImagePath ?? ""))
        } catch  {
            print("异常--")
        }
        
        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Update a progress bar.
            })
        }
        
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Alert a user for transfer completion.
                // On failed uploads, `error` contains the error object.
                //
                print("ssss success")
                
                self.delegate?.cleanImageCell(self, imageUploadSucceed: "", atIndex: self.indexpath)
            })
        }
        
        let transferUtility = AWSS3TransferUtility.default()
//        transferUtility.accessibilityCustomActions
        let key = "product/" + fileName + ".png"
        transferUtility.uploadData(data,
                                   bucket: "ostay-clean",
                                   key: key,
                                   contentType: "text/plain",
                                   expression: expression,
                                   completionHandler: completionHandler).continueWith {
                                    (task) -> AnyObject? in
                                    if let error = task.error {
                                        print("Error: \(error.localizedDescription)")
                                    }
                                    if let _ = task.result {
                                        // Do something with uploadTask.
                                    }
                                    return nil;
        }
    }
    
    
    
}
