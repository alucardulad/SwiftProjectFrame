//
//  APIConst.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/19.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

// MARK: - Gneral

// 用户
let editUserInfoUrl = "/cloud/v1/user/editUserInfo"
let getUserInfoUrl  = "/cloud/v1/user/getUserInfo"

/// 设备
let updateDeviceUrl = "/cloud/v1/deviceManaged/updateDevice"
let deleteDeviceUrl = "/cloud/v1/deviceManaged/deleteDevice"
let uploadImageUrl  = "/cloud/v1/user/uploadImage"

/// 日志
let uploadAppLogUrl = "/cloud/v1/log/uploadAppLog"

// MARK: - BodyFatScale
let createSubUserUrl = "/cloud/v2/user/createSubUserV2"
let updateSubUserUrl = "/cloud/v2/user/updateSubUserV2"
let getAllSubUserUrl = "/cloud/v2/user/getAllSubUserV2"
let deleteSubUserUrl = "/cloud/v2/user/deleteSubUserV2"
let getOneSubUserUrl = "/cloud/v2/user/getOneSubUserV2"
let uploadWeighingDataUrl = "/cloud/v2/deviceManaged/uploadWeighingDataV2"
let deleteWeighingDataUrl = "/cloud/v2/deviceManaged/deleteWeighingDataV2"
let getWeighingDataUrl    = "/cloud/v2/deviceManaged/getWeighingDataV2"
