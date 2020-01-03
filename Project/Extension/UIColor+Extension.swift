//
//  UIColor+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/7.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hexColor(_ hexColor: Int64) -> UIColor {
        
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func hexColor(_ hexColor: Int64, _ alpha: CGFloat) -> UIColor {
        
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
