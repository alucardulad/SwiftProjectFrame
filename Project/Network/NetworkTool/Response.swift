//
//  Response.swift
//  VeSync
//
//  Created by dave on 2019/10/29.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

// MARK: - 接口返回模型
struct Response<T>: HandyJSON {
    var traceId: String = ""
    var code: Int = 0
    var msg: String = ""
    var result: T?
}

// MARK: - Bypass 接口返回模型
struct BypassResponse<T: HandyJSON>: HandyJSON {
    var traceId: String = ""
    var code: Int = 0
    var msg: String = ""
    var result: BypassResult<T>?
}

struct BypassResult<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var msg: String = ""
    var result: T?
}
