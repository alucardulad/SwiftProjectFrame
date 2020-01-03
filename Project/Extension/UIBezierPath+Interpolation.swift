//
//  UIBezierPath+Interpolation.swift
//  VeSync
//
//  Created by dave on 2019/9/1.
//  Copyright © 2019年 Etekcity. All rights reserved.
//

import UIKit

private let kEPSILON: CGFloat = 1.0e-5

extension UIBezierPath {
    /// Hermite Curves算法 构造平滑贝塞尔
    static func interpolateCGPointsWithHermite(points: [CGPoint], closed: Bool) -> UIBezierPath? {
        if points.count < 2 { return nil }
        let nCurves = closed ? points.count : (points.count - 1)
        let path: UIBezierPath = UIBezierPath()
        for index in 0..<nCurves {
            let value = points[index]
            var curPt, prevPt, nextPt, endPt: CGPoint
            curPt = value
            if index == 0 { path.move(to: curPt) }
            
            var nexti = (index+1)%points.count
            var previ = (index-1 < 0 ? points.count-1 : index - 1)
            
            prevPt = points[previ]
            nextPt = points[nexti]
            endPt = nextPt
            
            var mx, my: CGFloat
            if closed || index > 0 {
                mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5
                my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5
            } else {
                mx = (nextPt.x - curPt.x)*0.5
                my = (nextPt.y - curPt.y)*0.5
            }
            
            let ctrlPt1 = CGPoint(x: curPt.x + mx/3.0, y: curPt.y + my/3.0)
            
            curPt = points[nexti]
            
            nexti = (nexti+1)%points.count
            previ = index
            
            prevPt = points[previ]
            nextPt = points[nexti]
            
            if closed || index < nCurves-1 {
                mx = (nextPt.x - curPt.x)*0.5 + (curPt.x - prevPt.x)*0.5
                my = (nextPt.y - curPt.y)*0.5 + (curPt.y - prevPt.y)*0.5
            } else {
                mx = (curPt.x - prevPt.x)*0.5
                my = (curPt.y - curPt.y)*0.5
            }
            
            let ctrlPt2 = CGPoint(x: curPt.x - mx/3.0, y: curPt.y - my/3.0)
            
            path.addCurve(to: endPt, controlPoint1: ctrlPt1, controlPoint2: ctrlPt2)
            
        }
        if closed { path.close() }
        return path
    }
    /// Catmull–Rom spline 算法 构造平滑贝塞尔
    /// https://en.wikipedia.org/wiki/Centripetal_Catmull%E2%80%93Rom_spline
    static func interpolateCGPointsWithCatmullRom(points: [CGPoint], closed: Bool, alpha: Float) -> UIBezierPath? {
        if points.count < 4 { return nil }
        let endIndex = (closed ? points.count : (points.count-2))
        assert(alpha >= 0.0 && alpha <= 1.0, "alpha value is between 0.0 and 1.0, inclusive")
        let path = UIBezierPath()
        let startIndex = (closed ? 0:1)
        for index in startIndex..<endIndex {
            var p0, p1, p2, p3: CGPoint
            let nexti = (index + 1)%points.count
            let nextnexti = (nexti + 1)%points.count
            let previ = (index - 1 < 0 ? points.count - 1 : index - 1)
            p1 = points[index]
            p0 = points[previ]
            p2 = points[nexti]
            p3 = points[nextnexti]
            
            let d1 = pointDistance(p1, p0)
            let d2 = pointDistance(p2, p1)
            let d3 = pointDistance(p3, p2)
            
            var b1, b2: CGPoint
            if abs(d1) < kEPSILON {
                b1 = p1
            } else {
                b1 = pointMult(p2, CGFloat(powf(Float(d1), 2*alpha)))
                b1 = pointSub(b1, pointMult(p0, CGFloat(powf(Float(d2), 2*alpha))))
                b1 = pointAdd(b1, pointMult(p1, CGFloat(2*powf(Float(d1), 2*alpha)+3*powf(Float(d1), alpha)*powf(Float(d2), alpha)+powf(Float(d2), 2*alpha))))
                b1 = pointMult(b1, CGFloat(1.0 / (3*powf(Float(d1), alpha)*(powf(Float(d1), alpha)+powf(Float(d2), alpha)))))
            }
            
            if abs(d3) < kEPSILON {
                b2 = p2
            } else {
                b2 = pointMult(p1, CGFloat(powf(Float(d3), 2*alpha)))
                b2 = pointSub(b2, pointMult(p3, CGFloat(powf(Float(d2), 2*alpha))))
                b2 = pointAdd(b2, pointMult(p2, CGFloat(2*powf(Float(d3), 2*alpha)+3*powf(Float(d3), alpha)*powf(Float(d2), alpha)+powf(Float(d2), 2*alpha))))
                b2 = pointMult(b2, CGFloat(1.0 / (3*powf(Float(d3), alpha)*(powf(Float(d3), alpha)+powf(Float(d2), alpha)))))
            }
            
            if index == startIndex { path.move(to: p1) }
            
            path.addCurve(to: p2, controlPoint1: b1, controlPoint2: b2)
        }
        if closed { path.close() }
        return path
    }
}
