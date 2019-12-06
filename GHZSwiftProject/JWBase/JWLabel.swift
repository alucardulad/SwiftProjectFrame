//
//  JWLabel.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/5.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class JWLabel: UILabel {

    @discardableResult
    func jwText(_ text: String) -> JWLabel {
        self.text = text
        return self
    }
    
    @discardableResult
    func jwTextColor(_ color: UIColor) -> JWLabel {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func jwFont(_ font: UIFont) -> JWLabel {
        self.font = font
        return self
    }
    
    @discardableResult
    func jwTextAlignment(_ textAlignment: NSTextAlignment) -> JWLabel {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func jwLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> JWLabel {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    func jwNumberOfLines(_ numberOfLines: Int) -> JWLabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func jwFrame(_ frame: CGRect) -> JWLabel {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func jwBackgroundColor(_ color: UIColor) -> JWLabel {
        self.backgroundColor = color
        return self
    }
}
