//
//  UIView+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/15.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

extension UIView {
    
    /// 渐变设置
    ///
    /// - Parameters:
    ///   - colors: 渐变颜色数组
    ///   - startPoint: 开始
    ///   - endPoint: 结束
    ///   - locations: 位置数组
    func gradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), locations: [Float]?, autoLaoutFrame: CGRect? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = (autoLaoutFrame != nil) ? autoLaoutFrame! : bounds
        gradient.colors = colors.map { color in return color.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        if let location = locations {
            gradient.locations = location as [NSNumber]
        }
        layer.insertSublayer(gradient, at: 0)
    }

    /// “叠加”视图事件处理
    ///
    //    +----------------------------+
    //    |A +--------+                |
    //    |  |B  +------------------+  |
    //    |  |   |C            X    |  |
    //    |  |   +------------------+  |
    //    |  |        |                |
    //    |  +--------+                |
    //    |                            |
    //    +----------------------------+
    func overlapHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        // 1、 不应为隐藏或透明视图或userInteractionEnabled设置为NO的视图发送触摸事件
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha == 0 {
            return nil
        }
        //2、如果触摸位于self内，则self将被视为潜在结果
        var hitView: UIView? = self
        if !self.point(inside: point, with: event) {
            if self.clipsToBounds {
                return nil
            } else {
                hitView = nil
            }
        }
        //3、 以递归方式检查所有匹配的子视图。如果有，请将其归还
        for subview in self.subviews.reversed() {
            let insideSubview = self.convert(point, to: subview)
            if let sview = subview.overlapHitTest(point: insideSubview, withEvent: event) {
                return sview
            }
        }
        return hitView
    }
}
