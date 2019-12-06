//
//  JWMacro.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class JWMacro: NSObject {
    enum JWiPhoneKind: Int {
        case iPhone4 = 0, iPhone4S, iPhone5, iPhone5c, iPhone5S, iPhone6, iPhone6P, iPhone6S, iPhone6SP, iPhoneSE, iPhone7, iPhone7P, iPhone8, iPhone8P, iPhoneX, iPhoneXR, iPhoneXS, iPhoneXSMax, iPhone11, iPhone11Pro, iPhone11ProMax
    }
    //苹果历代iPhone机型
    static let iPhones: [Int: (width: Double, height: Double)] = [JWiPhoneKind.iPhone4.rawValue: (320.0, 480.0),
                                                                 JWiPhoneKind.iPhone4S.rawValue: (320.0, 480.0),
                                                                 JWiPhoneKind.iPhone5.rawValue: (320.0, 568.0),
                                                                 JWiPhoneKind.iPhone5c.rawValue: (320.0, 568.0),
                                                                 JWiPhoneKind.iPhone5S.rawValue: (320.0, 568.0),
                                                                 JWiPhoneKind.iPhoneSE.rawValue: (320.0, 568.0),
                                                                 JWiPhoneKind.iPhone6.rawValue: (375.0, 667.0),
                                                                 JWiPhoneKind.iPhone6S.rawValue: (375.0, 667.0),
                                                                 JWiPhoneKind.iPhone7.rawValue: (375.0, 667.0),
                                                                 JWiPhoneKind.iPhone8.rawValue: (375.0, 667.0),
                                                                 JWiPhoneKind.iPhoneX.rawValue: (375.0, 812.0),
                                                                 JWiPhoneKind.iPhoneXS.rawValue: (375.0, 812.0),
                                                                 JWiPhoneKind.iPhone11Pro.rawValue: (375.0, 812.0),
                                                                 JWiPhoneKind.iPhone6P.rawValue: (414.0, 736.0),
                                                                 JWiPhoneKind.iPhone6SP.rawValue: (414.0, 736.0),
                                                                 JWiPhoneKind.iPhone7P.rawValue: (414.0, 736.0),
                                                                 JWiPhoneKind.iPhone8P.rawValue: (414.0, 736.0),
                                                                 JWiPhoneKind.iPhoneXR.rawValue: (414.0, 896.0),
                                                                 JWiPhoneKind.iPhoneXSMax.rawValue: (414.0, 896.0),
                                                                 JWiPhoneKind.iPhone11.rawValue: (414.0, 896.0),
                                                                 JWiPhoneKind.iPhone11ProMax.rawValue: (414.0, 896.0)]
    
    //当前屏幕分辨率
    static let screen_width = Double(UIScreen.main.bounds.size.width)
    static let screen_height = Double(UIScreen.main.bounds.size.height)
    //当前UI设计尺寸基础为
    static let iPhone = JWiPhoneKind.iPhone6
    static let iPhone_UI_width = JWMacro.iPhones[JWMacro.iPhone.rawValue]!.width
    static let iPhone_UI_height = JWMacro.iPhones[JWMacro.iPhone.rawValue]!.height
    //适配常用宏
    static let use_width = (JWMacro.screen_width > JWMacro.iPhone_UI_width ? JWMacro.iPhone_UI_width : JWMacro.screen_width)
    static let use_height = (JWMacro.screen_height > JWMacro.iPhone_UI_height ? JWMacro.iPhone_UI_height : JWMacro.screen_height)
    //状态栏高度
    static let statusBar_height = JWMacro.is_iPhoneX() ? 44.0 : 20.0
    //导航bar高度
    static let navigationBar_height = 44.0
    //整体导航栏高度（状态栏+bar）
    static let navigation_height = JWMacro.statusBar_height + JWMacro.navigationBar_height
    //十六进制RGB
    static func JWUIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: (CGFloat((rgbValue & 0xFF0000) >> 16))/255.0, green: (CGFloat(((rgbValue & 0xFF00) >> 8)))/255.0, blue: (CGFloat((rgbValue & 0xFF)))/255.0, alpha: 1.0)
    }
    //基于对应屏幕的UI设计的元素比例缩放
    static func frame_base_width(_ width: Double) -> Double {
        return width * JWMacro.use_width / JWMacro.iPhone_UI_width
    }
    
    static func frame_base_height(_ height: Double) -> Double {
        return height * JWMacro.use_height / JWMacro.iPhone_UI_height
    }
    //判断手机是否是iPhoneX
    static func is_iPhoneX() -> Bool {
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
}
