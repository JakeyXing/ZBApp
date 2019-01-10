//
//  CleanPicUploadView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/14.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry


/// 清扫房间图片 显示、上传部分
protocol CleanPicUploadViewDelegate: class {
    func cleanPicUploadView(_ cleanPicUploadView: CleanPicUploadView,didSelectedCell cell: CleanImageCell,atIndexPath indexPath: IndexPath,originUrl oriUrl : String?);
}

class CleanPicUploadView: UIView {
    
    weak var delegate: CleanPicUploadViewDelegate?
    
    var roomWithImagesArray:[ZB_TaskPhotoItem] = []
    var roomWithImagesArrayForUpload:[ZB_TaskPhotoItem] = []//
    var langDic:Dictionary<String,String>?
    private lazy var resultNameLabel: UILabel = UILabel.cz_label(withText: LanguageHelper.getString(key: "detail.cleanPic.uploadDes"), fontSize: kResizedFont(ft: 15), color: kFontColorGray)
    
    
    private lazy var resultLabel: UILabel = UILabel.cz_label(withText: "", fontSize: kResizedFont(ft: 15), color: RGBCOLOR(r: 254, 0, 5))
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = RGBCOLOR(r: 216, 216, 216)
        return content
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: kResizedPoint(pt: 100), height: kResizedPoint(pt: 96+10+36))
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
        collectionV.register(ClaenCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClaenCollectionHeaderView")
        return collectionV
        
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        langDic = sharedAppdelegate.langDic
        initView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congfigDataWithTask(model: ZB_Task){
        
        roomWithImagesArray = model.cleanPhotos!
        
        roomWithImagesArrayForUpload = roomWithImagesArray
        
        self.collectionView .reloadData()
        
    }
    
    func viewHeight() -> CGFloat {
        let headerH = kResizedPoint(pt: 17+30)
        let itemH = kResizedPoint(pt: 96+10+36)
        let cap:CGFloat = kResizedPoint(pt: 10)
        
        let count = self.roomWithImagesArray.count
        var viewH:CGFloat = 0
        
        for i in 0..<count {
            let photoItem = self.roomWithImagesArray[i]
            
            var arrCount = 0
            arrCount = photoItem.photos?.count ?? 0
            
            let nex = arrCount%3
            var h: CGFloat = 0
            
            if nex == 0 {
                h = CGFloat(arrCount/3)*(itemH+cap) - cap
            } else{
                h = CGFloat(arrCount/3)*(itemH+cap) + itemH
            }
            
            viewH = viewH + (headerH + h)
            
            
        }
        
      
        return kResizedPoint(pt: 10+17+20) + viewH + kResizedPoint(pt: 10)
    }
    
    
}

extension CleanPicUploadView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = kBgColorGray_238_235_220
        
        self.addSubview(self.resultNameLabel)
        self.addSubview(self.resultLabel)
        self.addSubview(self.contentView)
    
        self.contentView.addSubview(self.collectionView)
        
        
        self.subViewsLayout()
    }
    
    func subViewsLayout(){
        
        self.resultNameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(kResizedPoint(pt: 10))
            make.left.equalTo()(self.mas_left)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.resultLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.resultNameLabel.mas_centerY)
            make.left.equalTo()(self.resultNameLabel.mas_right)?.offset()(kResizedPoint(pt: 20))
            make.height.equalTo()(kResizedPoint(pt: 17))
        }
        
        self.contentView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.resultNameLabel.mas_bottom)?.offset()(kResizedPoint(pt: 20))
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


extension CleanPicUploadView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CleanImageCellDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.roomWithImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let photoItem = self.roomWithImagesArray[section]
        
        return photoItem.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader){
            let header:ClaenCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClaenCollectionHeaderView", for: indexPath) as! ClaenCollectionHeaderView
            let photoItem:ZB_TaskPhotoItem = self.roomWithImagesArray[indexPath.section]
            
            if langDic != nil && !(langDic?.isEmpty)! {
                header.roomNumLabel.text = langDic?[photoItem.location!]
            } else {
                header.roomNumLabel.text = photoItem.location!
            }
            return header
        }
        
        fatalError()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifierStr = "CleanImageCell\(indexPath.section)\(indexPath.row)"
        
        collectionView.register(CleanImageCell.self, forCellWithReuseIdentifier: identifierStr)
        let cell:CleanImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStr, for: indexPath) as! CleanImageCell
        cell.indexpath = indexPath
        cell.delegate = self
        
        let photoItem:ZB_TaskPhotoItem = self.roomWithImagesArray[indexPath.section]
        let photo: ZB_Photo = (photoItem.photos?[indexPath.row])!
        cell.imageView.sd_setImage(with: NSURL(string: (photo.url ?? photo.refUrl) ?? "")! as URL, completed: nil)
        
        if langDic != nil && !(langDic?.isEmpty)! {
            cell.nameLabel.text = langDic?[photo.position!]
        } else {
            cell.nameLabel.text = photo.position
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
   
        return CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20), height: kResizedPoint(pt: 17+30))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CleanImageCell = self.collectionView.cellForItem(at: indexPath) as! CleanImageCell
        
        let photoItem:ZB_TaskPhotoItem = self.roomWithImagesArray[indexPath.section]
        let photo: ZB_Photo = (photoItem.photos?[indexPath.row])!
        
        self.delegate?.cleanPicUploadView(self, didSelectedCell: cell,atIndexPath: indexPath,originUrl: (photo.url ?? photo.refUrl) ?? "")
    }
    
    //MARK:-CleanImageCellDelegate
    func cleanImageCell(_ cell: CleanImageCell, imageUploadSucceed imageUrl: String, atIndex indexPath: IndexPath) {
        let photoItem = self.roomWithImagesArrayForUpload[indexPath.section]
        let photo = photoItem.photos![indexPath.row]
        photo.upload = true
        photo.url = imageUrl
        
        let item:ZB_TaskPhotoItem = photoItem
        
        item.photos?[indexPath.row] = photo
        self.roomWithImagesArrayForUpload[indexPath.section] = photoItem
        
    }
    
    func cleanImageCell(_ cell: CleanImageCell, imageUploadFailedIndex indexPath: IndexPath) {
        
        
    }
    
    
    
}



