//
//  Const.swift
//  Assureapt
//
//  Created by Sheldon on 2019/8/7.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Siwft全局第三方常用库引用
@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxDataSources
@_exported import ReusableKit
@_exported import Then
@_exported import SnapKit
@_exported import HandyJSON
@_exported import SwiftyJSON

// MARK: - 常用尺寸
let kScreenBounds = UIScreen.main.bounds
let kScreenScale = UIScreen.main.scale
let kScreenSize = kScreenBounds.size
//当前屏幕分辨率
let kScreenW = kScreenSize.width
let kScreenH = kScreenSize.height
let kNavBarItemMargin: CGFloat = 20.0
//当前UI设计尺寸基础为
let kIPhone = IPhoneKind.iPhone6
let kIPhoneUIWidth: CGFloat = kIPhones[kIPhone]!.width
let kIPhoneUIHeight: CGFloat = kIPhones[kIPhone]!.height
//适配常用宏
let kUseWidth: CGFloat = (kScreenW > kIPhoneUIWidth ? kIPhoneUIWidth : kScreenW)
let kUseHeight: CGFloat = (kScreenH > kIPhoneUIHeight ? kIPhoneUIHeight : kScreenH)
//状态栏高度
let kStatusbarH: CGFloat = kIsIPhoneX() ? 44.0 : 20.0
//导航bar高度
let kNavigationBarHeight: CGFloat = 44.0
//整体导航栏高度（状态栏+bar）
let kNavibarH: CGFloat = kStatusbarH + kNavigationBarHeight
//电池高度
let kBatteryH: CGFloat = kIsIPhoneX() ? 24.0 : 20.0
//tabbar高度
let kTabbarH: CGFloat = kIsIPhoneX() ? 49.0 + 34.0 : 49.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0

// MARK: - 常用颜色
let kMainLgihtGray = kHexColor(0xf7f7f7)
let kMainGreen = kHexColor(0x0da778)
let kBackgroundColor = kHexColor(0xffffff)

// MARK: - 常用全局单例
let kUserDefualt = DataStorage.standard
let kNotificationCenter = NotificationCenter.default
let keyWindow = UIApplication.shared.keyWindow!

// MARK: - 常用闭包
typealias ActionClosure = () -> Void

// MARK: - APP&设备信息
let kAppInfoDict = Bundle.main.infoDictionary
let kAppCurrentVersion = kAppInfoDict!["CFBundleShortVersionString"]
let kAppBuildVersion = kAppInfoDict!["CFBundleVersion"]
let kDeviceIosVersion = UIDevice.current.systemVersion
let kDeviceIdentifierNumber = UIDevice.current.identifierForVendor
let kDeviceSystemName = UIDevice.current.systemName
let kDeviceModel = UIDevice.current.model
let kDeviceLocalizedModel = UIDevice.current.localizedModel
let isIPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
let isIPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)
let kIOS8 = (kDeviceIosVersion as NSString).doubleValue >= 8.0
let kIOS9 = (kDeviceIosVersion as NSString).doubleValue >= 9.0
let kIOS10 = (kDeviceIosVersion as NSString).doubleValue >= 10.0
let kIOS11 = (kDeviceIosVersion as NSString).doubleValue >= 11.0

// MARK: - 常用字体
@inline(__always) func kSystemRegularFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? kScaleWidth(size) : size
    let font = UIFont.systemFont(ofSize: fontSize)
    return font
}

@inline(__always) func kSystemBoldFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? kScaleWidth(size) : size
    let font = UIFont.boldSystemFont(ofSize: fontSize)
    return font
}

@inline(__always) func kSystemMediumFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? kScaleWidth(size) : size
    let font = UIFont.init(name: "PingFangSC-Medium", size: fontSize)
    return font!
}

@inline(__always) func kBebasFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? kScaleWidth(size) : size
    let font = UIFont.init(name: "BEBAS_s", size: fontSize)
    return font!
}

// MARK: - 等比例适配宏
@inline(__always) func kScaleWidth(_ width: CGFloat) -> CGFloat {
    return width * kUseWidth / kIPhoneUIWidth
}

@inline(__always) func kScaleHeight(_ height: CGFloat) -> CGFloat {
    return height * kUseHeight / kIPhoneUIHeight
}
//判断手机是否是iPhoneX
@inline(__always) func kIsIPhoneX() -> Bool {
    if #available(iOS 11.0, *) {
        if UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20.0 > CGFloat(20.0) {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}
// MARK: - 颜色方法
@inline(__always) func kRGBA(_ rValue: CGFloat, _ gValue: CGFloat, _ bValue: CGFloat, _ aValue: CGFloat) -> UIColor {
    
    return UIColor(red: rValue/255.0, green: gValue/255.0, blue: bValue/255.0, alpha: aValue)
}

@inline(__always) func kHexColor(_ hexColor: Int64, alpha: CGFloat = 1) -> UIColor {
    let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
    let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
    let blue = ((CGFloat)(hexColor & 0xFF))/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

@inline(__always) func kRandomColor() -> UIColor {
    return kRGBA(CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), 1)
}

// MARK: - 打印方法
@inline(__always) func VSLog(_ format: String, _ log: CVarArg...) {
    let str =  String(format: format, log)
    VSLogModule.vs_level(VSLogLevel.info, logStr: str)
}

/// RxSwift 资源打印
func logResourcesCount(file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    let file = (file as NSString).lastPathComponent
    let format = "RxSwift resources count: \(RxSwift.Resources.total)"
    let str =  "\(file):\(funcName):(\(lineNum))--\(format)"
    NSLog(str)
    #endif
}

func logDebug(_ format: String, _ log: CVarArg..., file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    let file = (file as NSString).lastPathComponent
    let str =  String(format: "\(file):\(funcName):(\(lineNum))--\(format)", log)
    NSLog(str)
    #endif
}

@inline(__always) func isIPhoneKind(phoneKind: IPhoneKind) -> Bool {
    let phoneSize = kIPhones[phoneKind]
    if CGFloat(phoneSize?.width ?? 0) == kScreenW {
        return true
    }
    return false
}
//苹果历代iPhone机型
enum IPhoneKind: Int {
    case iPhone4 = 0,
    iPhone4S,
    iPhone5,
    iPhone5c,
    iPhone5S,
    iPhone6,
    iPhone6P,
    iPhone6S,
    iPhone6SP,
    iPhoneSE,
    iPhone7,
    iPhone7P,
    iPhone8,
    iPhone8P,
    iPhoneX,
    iPhoneXR,
    iPhoneXS,
    iPhoneXSMax,
    iPhone11,
    iPhone11Pro,
    iPhone11ProMax
}
//苹果历代iPhone机型尺寸
let kIPhones: [IPhoneKind: (width: CGFloat, height: CGFloat)] =
    [IPhoneKind.iPhone4: (320.0, 480.0),
     IPhoneKind.iPhone4S: (320.0, 480.0),
     IPhoneKind.iPhone5: (320.0, 568.0),
     IPhoneKind.iPhone5c: (320.0, 568.0),
     IPhoneKind.iPhone5S: (320.0, 568.0),
     IPhoneKind.iPhoneSE: (320.0, 568.0),
     IPhoneKind.iPhone6: (375.0, 667.0),
     IPhoneKind.iPhone6S: (375.0, 667.0),
     IPhoneKind.iPhone7: (375.0, 667.0),
     IPhoneKind.iPhone8: (375.0, 667.0),
     IPhoneKind.iPhoneX: (375.0, 812.0),
     IPhoneKind.iPhoneXS: (375.0, 812.0),
     IPhoneKind.iPhone11Pro: (375.0, 812.0),
     IPhoneKind.iPhone6P: (414.0, 736.0),
     IPhoneKind.iPhone6SP: (414.0, 736.0),
     IPhoneKind.iPhone7P: (414.0, 736.0),
     IPhoneKind.iPhone8P: (414.0, 736.0),
     IPhoneKind.iPhoneXR: (414.0, 896.0),
     IPhoneKind.iPhoneXSMax: (414.0, 896.0),
     IPhoneKind.iPhone11: (414.0, 896.0),
     IPhoneKind.iPhone11ProMax: (414.0, 896.0)]
// MARK: - 多语言
extension String {
    var localized: String {
        return VSLanguageTool.instance.getString(forKey: self)
    }
}
