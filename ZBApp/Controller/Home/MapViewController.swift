//
//  MapViewController.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/18.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,JHNavigationBarDelegate {
    
    var address:ZB_Address?
    lazy var navigationBar: JHNavigationBar = {
        let view = JHNavigationBar(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.white
        view.titleLabel.text = LanguageHelper.getString(key: "detail.address.pageTitle")
        view.delegate = self
        return view
    }()
    
    //地图
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        self.configMap()
    }
    
    //MARK: - JHNavigationBarDelegate
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension MapViewController{
    func configMap() {
        
        self.mapView.frame = CGRect.init(x: 0, y: navigationBarHeight, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - navigationBarHeight)
        self.view.addSubview(self.mapView)
        self.mapView.mapType = .standard
        
        self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(address?.latitude ?? 0, address?.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        let annotattion = MKPointAnnotation.init()
        //latitude, CLLocationDegrees longitude) AP
        annotattion.coordinate = CLLocationCoordinate2DMake(address?.latitude ?? 0, address?.longitude ?? 0)
        annotattion.title = address?.name
        annotattion.subtitle = ""
    
        self.mapView.addAnnotation(annotattion)

//        self.mapView.delegate = self

    }
}
