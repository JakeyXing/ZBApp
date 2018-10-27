//
//  ZB_Task.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import YYModel
class ZB_Task: NSObject,YYModel {
    @objc  var acceptance: String?
    @objc  var base: Float = 0
    @objc  var bonus: Float = 0
    @objc  var currency: String?
    @objc  var endDate: String?
    @objc  var durationFromDeadline: Float = 0
    @objc  var fine: Float = 0
    @objc  var id: Int64 = 0
    @objc  var imgs: [String]?
    @objc  var cleanPhotos: [ZB_TaskPhotoItem]?
    @objc  var maintainPhotos: [ZB_UploadImageItem]?
    @objc  var progress: String?
    @objc  var startDate: String?
    @objc  var taskInfo: ZB_TaskInfo?
    @objc  var taskLogs: [ZB_TaskLog]?
    @objc  var qualityIssueCount: Int = 0
    @objc  var restHours: Int = 0
    
  
    override var description: String {
        return yy_modelDescription()
    }

    private class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["photos": ZB_TaskPhotoItem.self,"taskLogs": ZB_TaskLog.self,"maintainPhotos": ZB_UploadImageItem.self]
    }

}
