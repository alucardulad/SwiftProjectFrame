//
//  CGPoint+Extension.swift
//  VeSync
//
//  Created by dave on 2019/9/1.
//  Copyright © 2019年 Etekcity. All rights reserved.
//

import Foundation

/// 两个点相减
@inline(__always) func pointSub(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}

/// 两个点相加
@inline(__always) func pointAdd(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

/// 一个点x, y 分别与一个数相乘
@inline(__always) func pointMult(_ point: CGPoint, _ value: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * value, y: point.y * value)
}

/// 两个点距离
@inline(__always) func pointDistance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    let xDist2: CGFloat = pow((p1.x - p2.x), 2)
    let yDist2: CGFloat = pow((p1.y - p2.y), 2)
    return sqrt(xDist2 + yDist2)
}
