//
//  RepairPicUploadView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/15.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry
import JXPhotoBrowser

protocol RepairPicUploadViewDelegate: class {
    func repairPicUploadView(_ cleanPicUploadView: RepairPicUploadView,didSelectedAtIndexPath indexPath: IndexPath);
}

class RepairPicUploadView: UIView {
    
    
    var currentUploadmediaType: UploadMediaType = .image
    weak var delegate: RepairPicUploadViewDelegate?
    
    var roomWithImagesArray:[[UIImage]] = []
    
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
        collectionV.register(RepairHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RepairHeaderView")
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
    
    
    func congfigData() {
        roomWithImagesArray = [[],[]]
        
    }
    
    func viewHeight() -> CGFloat {
        let headerH = kResizedPoint(pt: 10+10+19+5+17+10)
        let itemH = kResizedPoint(pt: 90+15+5)
        let cap:CGFloat = kResizedPoint(pt: 10)
        
        let count = self.roomWithImagesArray.count
        var viewH:CGFloat = 0
        
        for i in 0..<count {
            let arr = self.roomWithImagesArray[i]
            
            let arrCount = arr.count + 1
            
            let nex = arrCount%3
            var h: CGFloat = 0
            
            if nex == 0 {
                h = CGFloat(arrCount/3)*(itemH+cap)-cap
            } else{
                h = CGFloat(arrCount/3)*(itemH+cap)+itemH
            }
            
            viewH = viewH + (headerH + h)
            
            
        }
        
        
        return kResizedPoint(pt: 20) + viewH + kResizedPoint(pt: 10)
    }
    
    func addAndUploadImage(img: UIImage, atIndexPath indexpath: NSIndexPath) {
        currentUploadmediaType = .video
        
        var arr = self.roomWithImagesArray[indexpath.section]
        arr.append(img)
        self.roomWithImagesArray[indexpath.section] = arr
        
        self.collectionView.reloadData()
        
    }
    
    func addAndUploadVideo(url: NSURL, atIndexPath indexpath: NSIndexPath) {
//        let videoName = "repa_v_" + CommonMethod.timestamp() + ".mp4"
//        let videoURLStr = NSHomeDirectory() + "/Documents/" + videoName
//        let newVideoURL: NSURL = NSURL(fileURLWithPath: videoURLStr)
//        CommonMethod.convertVideoQuailty(withInputURL: url as URL, outputURL: newVideoURL as URL) { (aa) in
//
//        }
        currentUploadmediaType = .video
        
        var arr = self.roomWithImagesArray[indexpath.section]
        let videoImg = CommonMethod.getVideoPreViewImage(url as URL)
        
        arr.append(videoImg!)
        self.roomWithImagesArray[indexpath.section] = arr
        
        self.collectionView.reloadData()
        
    }
    
    
}

extension RepairPicUploadView{
    
    //MARK: - private methods
    
    func initView(){
        self.backgroundColor = kBgColorGray_238_235_220
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.collectionView)
        
        
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


extension RepairPicUploadView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,RepairImageCellDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.roomWithImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arr = self.roomWithImagesArray[section]
        
        return arr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RepairHeaderView", for: indexPath)
            return header
        }
        
        fatalError()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifierStr = "RepairImageCell\(indexPath.section)\(indexPath.row)"
        let identifierStrAdd = "repairAddCell\(indexPath.section)\(indexPath.row)"
        
        collectionView.register(RepairImageCell.self, forCellWithReuseIdentifier: identifierStr)
        collectionView.register(repairAddCell.self, forCellWithReuseIdentifier: identifierStrAdd)
        
        let arr = self.roomWithImagesArray[indexPath.section]
        if indexPath.row < arr.count {
            let cell:RepairImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStr, for: indexPath) as! RepairImageCell
            cell.imageView.image = arr[indexPath.row]
            cell.indexpath = indexPath as NSIndexPath
            cell.delegate = self
            if (indexPath.row == arr.count - 1){
                cell.mediaType = currentUploadmediaType
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStrAdd, for: indexPath)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: DEVICE_WIDTH, height: kResizedPoint(pt: 10+10+19+5+17+10))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let arr = self.roomWithImagesArray[indexPath.section]
        if indexPath.row < arr.count {
            PhotoBrowser.show(localImages: arr, originPageIndex: indexPath.row)
        }else{
            self.delegate?.repairPicUploadView(self, didSelectedAtIndexPath: indexPath)
        }
        
    }
    
     //MARK: - RepairImageCellDelegate
    func repairImageCell(_ cell: RepairImageCell, didClosedAtIndexPath indexPath: IndexPath) {
        var arr = self.roomWithImagesArray[indexPath.section]
        arr.remove(at: indexPath.row)
        self.roomWithImagesArray[indexPath.section] = arr
        
        self.collectionView.reloadData()
    }
    
    
}

