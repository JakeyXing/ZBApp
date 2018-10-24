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
let BaseApiUrl = "http://172.168.6.18:8081"


let LoginUrl = BaseApiUrl + "/auth/login"
let RegisterUrl = BaseApiUrl + "/auth/phone/register"
let PhoneCodeUrl = BaseApiUrl + "/auth/phone/code"
let ResetPassUrl = BaseApiUrl + "/auth/phone/resetPwd"
let PendingTaskListUrl = BaseApiUrl + "/task/pending"  //待抢任务list(首页)
let ExecuteTaskListUrl = BaseApiUrl + "/task/execute/list"
let TaskDetailUrl = BaseApiUrl + "/task/execute/detail"  //任务详情

