//
//  ZB_Task.swift
//  ZBApp
//
//  Created by xingjiehai on 2018/10/21.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import UIKit
import ObjectMapper

class ZB_Task: Mappable {
var acceptance: String?
    var base: Float = 0
    var bonus: Float = 0
    var currency: String?
    var endDate: String?
    var durationFromDeadline: Float = 0
    var fine: Float = 0
    var id: Int64 = 0
    var imgs: [String]?
    var cleanPhotos: [ZB_TaskPhotoItem]?
    var maintainPhotos: [ZB_UploadImageItem]?
    var progress: String?
    var startDate: String?
    var taskInfo: ZB_TaskInfo?
    var taskLogs: [ZB_TaskLog]?
    var qualityIssueCount: Int = 0
    var restHours: Int = 0
    
    //我的任务列表使用
    var address: ZB_Address?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        acceptance          <- map["acceptance"]
        base       <- map["base"]
        bonus <- map["bonus"]
        currency <- map["currency"]
        endDate  <- map["endDate"]
        durationFromDeadline <- map["durationFromDeadline"]
        fine  <- map["fine"]
        id   <- map["id"]
        imgs    <- map["imgs"]
        cleanPhotos   <- map["cleanPhotos"]
        maintainPhotos  <- map["maintainPhotos"]
        progress     <- map["progress"]
        startDate  <- map["startDate"]
        taskInfo      <- map["taskInfo"]
        taskLogs     <- map["taskLogs"]
        qualityIssueCount       <- map["qualityIssueCount"]
        restHours       <- map["restHours"]
        address       <- map["address"]
        type       <- map["type"]
        
    }

}
