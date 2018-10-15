//
//  RepairPicUploadView.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/15.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import Masonry


protocol RepairPicUploadViewDelegate: class {
    func cleanPicUploadView(_ cleanPicUploadView: RepairPicUploadView,didSelectedCell cell: RepairImageCell);
}

class RepairPicUploadView: UIView {
    
    weak var delegate: RepairPicUploadViewDelegate?
    
    var roomWithImagesArray:[[String]] = []
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = RGBCOLOR(r: 216, 216, 216)
        return content
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: kResizedPoint(pt: 96), height: kResizedPoint(pt: 90+10+5))
        let collectionV = UICollectionView(frame: CGRect.init(), collectionViewLayout: flowLayout)
        flowLayout.minimumInteritemSpacing = kResizedPoint(pt: 10)
        flowLayout.minimumLineSpacing = kResizedPoint(pt: 10)
        
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
        roomWithImagesArray = [["","","","","",""],["","","","","",""]]
        
    }
    
    func viewHeight() -> CGFloat {
        let headerH = kResizedPoint(pt: 10+10+19+5+17+10)
        let itemH = kResizedPoint(pt: 90+10+5)
        let cap:CGFloat = kResizedPoint(pt: 10)
        
        let count = self.roomWithImagesArray.count
        var viewH:CGFloat = 0
        
        for i in 0..<count {
            let arr = self.roomWithImagesArray[i]
            
            let arrCount = arr.count
            
            let nex = arrCount%3
            var h: CGFloat = 0
            
            if nex == 0 {
                h = CGFloat(arrCount/3)*kResizedPoint(pt: itemH+cap)-kResizedPoint(pt: cap)
            } else{
                h = CGFloat(arrCount/3)*kResizedPoint(pt: itemH+cap)+kResizedPoint(pt: height)
            }
            
            viewH = viewH + (headerH + h)
            
            
        }
        
        
        return kResizedPoint(pt: 20) + viewH + kResizedPoint(pt: 10)
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


extension RepairPicUploadView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.roomWithImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arr = self.roomWithImagesArray[section]
        
        return arr.count
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
        
        collectionView.register(RepairImageCell.self, forCellWithReuseIdentifier: identifierStr)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierStr, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: DEVICE_WIDTH-kResizedPoint(pt: 20), height: kResizedPoint(pt: 10+10+19+5+17+10))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CleanImageCell = self.collectionView(collectionView, cellForItemAt: indexPath) as! CleanImageCell
//        self.delegate?.cleanPicUploadView(self, didSelectedCell: cell)
        
        
    }
    
    
}

