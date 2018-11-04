//
//  FeedbackImageUploadView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/11/4.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import SKPhotoBrowser

protocol FeedbackImageUploadViewDelegate: class {
    func feedbackImageUploadView(_ view: FeedbackImageUploadView,didSelectedAtIndex index: NSInteger);
    func feedbackImageUploadViewDidUplaodSuccess(_ view: FeedbackImageUploadView);
}

class FeedbackImageUploadView: UIView {
    
    var currentUploadmediaType: UploadMediaType = .image
    weak var delegate: FeedbackImageUploadViewDelegate?
    
    var imagesArray:[String]?
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = RGBCOLOR(r: 216, 216, 216)
        return content
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: kResizedPoint(pt: 102), height: kResizedPoint(pt: 90+15+5))
        let collectionV = UICollectionView(frame: CGRect.init(), collectionViewLayout: flowLayout)
        flowLayout.minimumInteritemSpacing = kResizedPoint(pt: 5)
        flowLayout.minimumLineSpacing = kResizedPoint(pt: 10)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        
        collectionV.backgroundColor = RGBCOLOR(r: 216, 216, 216)
        collectionV.isScrollEnabled = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.scrollsToTop = false
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        return collectionV
        
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    func congfigDataWithTask(info: ZB_Task){
//        self.roomWithImagesArray = info.maintainPhotos
//
//        self.collectionView.reloadData()
//
//    }
    
    func viewHeight() -> CGFloat {
       
        let itemH = kResizedPoint(pt: 90+15+5)
        let cap:CGFloat = kResizedPoint(pt: 10)
        
        let photoCount = self.imagesArray?.count
        let arrCount = (photoCount ?? 0) + 1
        
        let nex = arrCount%3
        var h: CGFloat = 0
        
        if nex == 0 {
            h = CGFloat(arrCount/3)*(itemH+cap)-cap
        } else{
            h = CGFloat(arrCount/3)*(itemH+cap)+itemH
        }
        
        return kResizedPoint(pt: 20) + h + kResizedPoint(pt: 20)
    }
    
    func addAndUploadImage(img: UIImage, atIndexPath index: NSInteger) {
        currentUploadmediaType = .image
    
        let imgName = "feedback_pic_" + CommonMethod.timestamp()
        let savedImagePath = CommonMethod.getImagePath(img, imageName: imgName)
        let fileNa = imgName + ".png"
        uploadDataToAWS(fileName: fileNa, filePath: savedImagePath!, success: { (url) in
            
            DispatchQueue.main.async(execute: {
                
                self.imagesArray?.append(url ?? "")
                self.collectionView.reloadData()
                self.delegate?.feedbackImageUploadViewDidUplaodSuccess(self)
               
                
            })
            
            
            
        }) { (errMsg) in
            
            
        }
        
    }
    
    
}

extension FeedbackImageUploadView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = kBgColorGray_238_235_220
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.collectionView)
        
        self.imagesArray = [String]()
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 20))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.right.equalTo()(self.mas_right)?.offset()(kResizedPoint(pt: -20))
            make.bottom.equalTo()(self.mas_bottom)
        }
        
        self.collectionView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.contentView.mas_top)?.offset()(kResizedPoint(pt: 0))
            make.left.equalTo()(self.contentView)?.offset()(kResizedPoint(pt: 0))
            make.right.equalTo()(self.contentView.mas_right)?.offset()(kResizedPoint(pt: 0))
            make.bottom.equalTo()(self.contentView.mas_bottom)
        }
        
    }
    
}


extension FeedbackImageUploadView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,RepairImageCellDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let arrCount = (self.imagesArray?.count ?? 0) + 1
        
        return arrCount
 
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifierStr = "RepairImageCell\(indexPath.section)\(indexPath.row)"
        let identifierStrAdd = "repairAddCell\(indexPath.section)\(indexPath.row)"
        
        collectionView.register(RepairImageCell.self, forCellWithReuseIdentifier: identifierStr)
        collectionView.register(repairAddCell.self, forCellWithReuseIdentifier: identifierStrAdd)
        
   
        let arrCount = self.imagesArray?.count ?? 0
        
        if indexPath.row < arrCount {
            let cell:RepairImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStr, for: indexPath) as! RepairImageCell
            let imageUrl = self.imagesArray?[indexPath.row]
            
            cell.imageView.sd_setImage(with: URL(fileURLWithPath: imageUrl ?? ""), completed: nil)
            cell.indexpath = indexPath as NSIndexPath
            cell.delegate = self
            if (indexPath.row == arrCount - 1){
                cell.mediaType = currentUploadmediaType
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStrAdd, for: indexPath)
            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        let arr = self.roomWithImagesArray[indexPath.section]
        let arrCount = self.imagesArray?.count ?? 0
        
        if indexPath.row < arrCount {
            //            let count = arr.count
            
            var images = [SKPhoto]()
            for i in 0..<arrCount{
                let imageUrl = self.imagesArray?[indexPath.row]
                let photo = SKPhoto.photoWithImageURL(imageUrl ?? "")
                photo.shouldCachePhotoURLImage = false
                images.append(photo)
            }
            
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(indexPath.row)
            self.viewContainingController()!.present(browser, animated: true, completion: {})
        }else{
            self.delegate?.feedbackImageUploadView(self, didSelectedAtIndex: indexPath.row)
        }
        
    }
    
    //MARK: - RepairImageCellDelegate
    func repairImageCell(_ cell: RepairImageCell, didClosedAtIndexPath indexPath: IndexPath) {
        //        var arr = self.roomWithImagesArray[indexPath.section]
        //        arr.remove(at: indexPath.row)
        //        self.roomWithImagesArray[indexPath.section] = arr
        
        self.imagesArray?.remove(at: indexPath.row)
        self.collectionView.reloadData()
        self.delegate?.feedbackImageUploadViewDidUplaodSuccess(self)
    }
    
    
}
