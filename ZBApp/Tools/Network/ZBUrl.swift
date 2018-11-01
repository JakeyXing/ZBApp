//
//  ZBUrl.swift
//  ZBApp
//
//  Created by lxr on 2018/10/20.
//  Copyright © 2018年 ParentsChat. All rights reserved.
//

import Foundation

let refreshData_msg = "kErrorMsgForRefreshData"

//
let kAccessTokenTokenInvalidNoti = "kAccessTokenTokenInvalidNoti"
let kNoRefreshTokenNoti = "kNoRefreshTokenNoti"
let kRefreshTokenInvalidNoti = "kRefreshTokenInvalidNoti"

let refreshAccessTokenApiUrl = BaseApiUrl + "/auth/token/refresh"
let BaseApiUrl = "http://api.crowd.iwcln.com"   //  http://172.168.6.18:8081 http://api.crowd.iwcln.com


let LoginUrl = BaseApiUrl + "/auth/login"
let RegisterUrl = BaseApiUrl + "/auth/phone/register"
let PhoneCodeUrl = BaseApiUrl + "/auth/phone/code"
let ResetPassUrl = BaseApiUrl + "/auth/phone/resetPwd"
let PendingTaskListUrl = BaseApiUrl + "/task/pending"  //待抢任务list(首页)
let ExecuteTaskListUrl = BaseApiUrl + "/task/execute/list"
let TaskDetailUrl = BaseApiUrl + "/task/execute/detail"  //任务详情
let ReceiveTaskUrl = BaseApiUrl + "/task/receive"  //抢单
let TransferTaskUrl = BaseApiUrl + "/task/execute/transfer"  //转单
let StartTaskUrl = BaseApiUrl + "/task/execute/start"  //开始执行任务
let ApproveTaskUrl = BaseApiUrl + "/task/execute/approve"  //提交审核
let UserInfoUrl = BaseApiUrl + "/userInfo/myInfo"  //个人信息
let ReportTaskQuesUrl = BaseApiUrl + "/task/execute/report"  //上报问题
let ApplyUrl = BaseApiUrl + "/userInfo/apply"  //资质申请
let ApplyCityUrl = BaseApiUrl + "/config/cities"  //citys






