//
//  NetworkError.swift
//  VeSync
//
//  Created by dave on 2019/11/1.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

// 网络错误
public enum NetworkError: Error {
    case error(code: Int?, msg: String?)
    // 转换模型错误
    case modelMapping
}

// MARK: - Error Descriptions

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(_, let msg):
            return msg
        case .modelMapping:
            return "model mapping fail"
        }
    }
    
    public static func msgWithError(error: Error) -> String {
        let err = error as NSError
        return err.description
    }
    
    public static func newHanleErrorCode(code: Int) -> String {
        if code == -11001 {
            #warning ("用户重新登录设置")
            return ""
        }
        
        let errMsg: String?
    
        switch (code) {
        case -11000: errMsg = "4001005".localized //参数不合法
        case -11001: errMsg = "4001004".localized //token过期
        case -11003: errMsg = "11003".localized //请求频率过高
        case -11004: errMsg = "oop_wrong".localized //方法名没找到
        case -11005: errMsg = "11005".localized //请求资源不存在
        case -11100: errMsg = "oop_wrong".localized //运行模块操作数据库失败
        case -11101: errMsg = "oop_wrong".localized //运行模块操作数据库失败
        case -11102: errMsg = "oop_wrong".localized //运行模块内部导致的错误（比如空指针异常）
        case -11103: errMsg = "11103".localized //服务器繁忙
        case -11104: errMsg = "11104".localized //服务器超时
        case -11105: errMsg = "oop_wrong".localized //mysql错误
        case -11106: errMsg = "oop_wrong".localized //Redis错误错误
        case -11107: errMsg = "oop_wrong".localized //MongoDB错误
        case -11108: errMsg = "oop_wrong".localized //s3错误
        case -11200: errMsg =  "oop_wrong".localized //账户格式错误
        case -11201: errMsg = "11201".localized //密码不正确
        case -11202: errMsg = "11202".localized //账号不存在
        case -11203: errMsg = "11203".localized //账号已注册
            
        //设备相关
        case -11300: errMsg = "4041004".localized //设备离线
        case -11301: errMsg = "11301".localized //设备不存在
        case -11302: errMsg = "11104".localized //请求设备超时
        case -11303: errMsg = "11303".localized //固件已是最新版本
        case -11304: errMsg = "oop_wrong".localized //设备时区不相同
        case -11305: errMsg = "oop_wrong".localized //configModule 不存在
        case -11306: errMsg = "11306".localized //用户与设备已绑定
        case -11307: errMsg = "11307".localized //uuid不存在
        case -11308: errMsg = "11308".localized //设备列表不全
        case -11400: errMsg = "11400".localized //共享人不存在
        case -11401: errMsg = "11401".localized //不能分享给自己
            
        //定时器相关
        case -11500: errMsg = "11500".localized //定时器不存在
        case -11501: errMsg = "oop_wrong".localized //定时器冲突
        case -11502: errMsg = "11502".localized //schedule个数已达上限
        case -11503: errMsg = "11503".localized //timer(倒计时)个数已达上限
        case -11504: errMsg = "11504".localized //away个数已达上限
            
        //图片相关
        case -11600: errMsg = "4031003".localized //文件类型错误
        case -11601: errMsg = "11601".localized //文件过大
            
        //喜好相关
        case -11700: errMsg = "11700".localized //喜好数量已达上限
            
        //第三方商家相关
        case -11900: errMsg = "oop_wrong".localized //authKey和pid不匹配
        case -11901: errMsg = "11901".localized //pid不存在
        case -11902: errMsg = "oop_wrong".localized //authKey不存在
            
        //配网相关
        case -12000: errMsg = "11901".localized //configKey不存在
        case -12001: errMsg = "11104".localized //configKey过期
        case -12002: errMsg = "12002".localized //设备重复注册
        case -12003: errMsg = "12003".localized //设备配网信息没找到
        case -11210: errMsg = "11210".localized // 子用户昵称已被使用
        case -11212: errMsg = "11212".localized
        case -11213: errMsg = "11213".localized
        case -11214: errMsg = "11214".localized
        case -11215: errMsg = "11215".localized
        case -11217: errMsg = "11217".localized
        default:
            errMsg = "Unknown Error  \(code)".localized
        }
        return errMsg ?? ""
    }    
}
