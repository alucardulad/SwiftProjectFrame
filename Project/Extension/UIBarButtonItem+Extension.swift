//
//  UIBarButtonItem+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/7.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 导航栏按钮(图片)
    ///
    /// - Parameters:
    ///   - direction: true: 左边 false: 右边
    static func barButtonItem(_ normalImageName: String, _ highImageName: String?, _ target: Any?, _ action: Selector, _ direction: Bool) -> [UIBarButtonItem] {
        
        let button = UIButton(type: .custom)
        let normalImage = UIImage(named: normalImageName)
        button.setImage(normalImage, for: .normal)
        button.frame.size = (normalImage?.size)!
        if highImageName != nil {
            button.setImage(UIImage(named: highImageName!), for: .highlighted)
        }
        button.addTarget(target, action: action, for: .touchUpInside)
//        // IOS11 fixedSpace 失效，使用此方法
//        if kIOS11 {
//            button.imageEdgeInsets = direction ? UIEdgeInsetsMake(0, Metric.ios11Imageinset, 0, 0) : UIEdgeInsetsMake(0, 0, 0, Metric.ios11Imageinset)
//            button.contentHorizontalAlignment = direction ? .left : .right
//            return [UIBarButtonItem(customView: button)]
//        }
//        // 按钮间距为6，6P间距为20，6位16
//        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        fixedSpace.width = Metric.systemMargin
//        return [fixedSpace, UIBarButtonItem(customView: button)]
        return [UIBarButtonItem(customView: button)]
    }
    
    /// 导航栏按钮(文字)
    ///
    /// - Parameters:
    ///   - direction: true: 左边 false: 右边
    static func barButtonItem(_ title: String?, _ target: Any?, _ action: Selector, _ direction: Bool) -> [UIBarButtonItem] {
        
        let button = UIButton(type: .custom)
//        button.titleLabel?.font = kNavBarItemFont
//        button.setTitleColor(kNavBarItemTextColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        return [UIBarButtonItem(customView: button)]
    }
}
