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
import AWSCognito
import AFNetworking


/// 清扫位置图片
protocol CleanImageCellDelegate: class {
    func cleanImageCell(_ cell: CleanImageCell,imageUploadSucceed imageUrl: String,atIndex indexPath:IndexPath)
    
    func cleanImageCell(_ cell: CleanImageCell,imageUploadFailedIndex indexPath:IndexPath)
    
}
class CleanImageCell: UICollectionViewCell {
    weak var delegate: CleanImageCellDelegate?
    
    let websites = [
        "https://s3-ap-northeast-1.amazonaws.com",
        "https://www.google.com",
        "https://developer.apple.com",]
    
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
    
    lazy var progressView: UIView = {
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
    
    func uploadImage(img:UIImage,netTestManager:AFHTTPSessionManager) {
//        self.imageView.image = img
        self.oriImage = img
        let imgName = "clen_pic_" + CommonMethod.timestamp() + "_" + "\(getUserInfo()["id"]!)"
//        let imgName = "testtest"

        self.imageView.image = CommonMethod.image(withImageSimple: img, scaledTo: CGSize.init(width: 750, height: 750))
        // [self imageWithImageSimple:Image scaledToSize:CGSizeMake(1080, 1080)]
        self.savedImagePath = CommonMethod.getImagePath(img, imageName: imgName)
        
        let fileNa = imgName + ".jpg"
        
        uploadDataToAWS(fileName: fileNa, filePath: self.savedImagePath!, success: { (url) in
            self.delegate?.cleanImageCell(self, imageUploadSucceed: url ?? "", atIndex: self.indexpath)
            myPrint(items: "change green")
            DispatchQueue.main.async(execute: {
                self.progressView.backgroundColor = UIColor.green
            })
        }) { (errMsg) in
            myPrint(items: "change red")
            DispatchQueue.main.async(execute: {
                self.progressView.backgroundColor = UIColor.red
            })
        }

        for website in websites {
            let start = Date().timeIntervalSince1970
            netTestManager.get(website, parameters: nil, progress: nil, success: { (task, any) in
                let end = Date().timeIntervalSince1970
                let gap = end - start
                print("\(website) success ----> gap:\(gap)")
            }) { (task, error) in
                let end = Date().timeIntervalSince1970
                let gap = end - start
                print("\(website) fail ----> gap:\(gap)")
                var params = ["fileUrl":fileNa]
                params["testWebsite"] = website
                params["timeout"] = "\(gap)"
                netTestManager.get("http://www.ostay.cc", parameters: params, progress: nil, success: { (urlSessionDataTask, any) in
                    print("success ----> ")
                }) { (urlSessionDataTask, error) in
                    print("error ----> \(error.localizedDescription)")
                }
            }
        }
//        self.uploadData(fileName: imgName)
    
    }
    
    
    func uploadData(fileName: String) {
        
        let key = "product/" + fileName + ".jpg"
      
        print("\(String(describing: self.savedImagePath))")
        let fileUrl = URL(fileURLWithPath: self.savedImagePath ?? "")
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.bucket = "ostay-clean"
        uploadRequest?.key = key
        uploadRequest?.body = fileUrl
        uploadRequest?.acl = AWSS3ObjectCannedACL.publicRead
        uploadRequest?.uploadProgress = { (bytesSent, totalBytesSent, totalBytesExpectedToSend) -> Void in
            DispatchQueue.main.async(execute: {
                print("\(bytesSent)")
            })
        }
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.APNortheast1, identityPoolId:"us-east-1:4f288687-b535-414d-b9a3-abe2daf9b616")
        let configuration = AWSServiceConfiguration(region: AWSRegionType.APNortheast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        let transferManager = AWSS3TransferManager.default()

        // check network status
        transferManager.upload(uploadRequest!).continueWith { (taskk: AWSTask) -> Any? in
            if taskk.error != nil {
                // Error.
                print("failed\(taskk.error.debugDescription)")
            } else {
                print("SSSSSuccess")
                self.delegate?.cleanImageCell(self, imageUploadSucceed: "", atIndex: self.indexpath)
            }
            return nil
            
        }
    }
    
    
    
}
