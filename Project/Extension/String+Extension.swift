//
//  String+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/15.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - 获取字符串大小
    func getSize(font: UIFont, width: CGFloat = UIScreen.main.bounds.width) -> CGSize {
        let str = self as NSString
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
    // MARK: - 十六进制的字符串转数字
    func hexStringToInt() -> Int {
        let str = self.uppercased()
        var sum = 0
        for index in str.utf8 {
            sum = sum * 16 + Int(index) - 48
            if index >= 65 {
                sum -= 7
            }
        }
        return sum
    }
    
    var url: URL? {
        return URL(string: self)
    }

    /// 清除浮点数格式化的字符串多余的0
    var cleanZero: String? {
        let number = Double(self)
        if let number = number {
            return String(format: "%@", NSNumber(value: number))
        }
        return nil
    }
    
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    /// 去掉首尾空格 包括后面的换行
    var removeHeadAndTailSpacePro: String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
}
