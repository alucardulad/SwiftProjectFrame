//
//  JWButton.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/5.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class JWButton: UIButton {
    
    enum LayoutStyle {
        case topImage_bottomTitle
        case bottomImage_topTitle
        case leftImage_rightTitle
        case rightImage_leftTitle
    }
    
    private var jw_style: JWButton.LayoutStyle?
    private var jw_space: CGFloat?
    private var jw_action: ((JWButton) -> Void)?

    @discardableResult
    func jwFont(_ font: UIFont) -> JWButton {
        self.titleLabel?.font = font
        return self
    }

    @discardableResult
    func jwTitle(_ title: String, for state: UIControl.State) -> JWButton {
        self.setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func jwImage(_ image: UIImage, for state: UIControl.State) -> JWButton {
        self.setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func jwTitleColor(_ color: UIColor, for state: UIControl.State) -> JWButton {
        self.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func jwBackgroundColor(_ color: UIColor) -> JWButton {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func jwFrame(_ frame: CGRect) -> JWButton {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func jwLayerCornerRadius(_ radius: CGFloat) -> JWButton {
        self.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func jwClipsToBounds(_ isClip: Bool) -> JWButton {
        self.clipsToBounds = isClip
        return self
    }
    
    @discardableResult
    func jwLayerBorderColor(_ color: UIColor) -> JWButton {
        self.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func jwBackgroundImage(_ image: UIImage, for state: (UIControl.State)) -> JWButton {
        self.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func jwAttributedTitle(_ attributeString: NSAttributedString, state: UIControl.State) -> JWButton {
        self.setAttributedTitle(attributeString, for: state)
        return self
    }
    
    @discardableResult
    func jwButtonLayoutStyle(_ style: JWButton.LayoutStyle, space: CGFloat) -> JWButton {
        self.jw_style = style
        self.jw_space = space
        
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        
        if Double(UIDevice.current.systemVersion)! >= 8.0 {
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        } else {
            labelWidth = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .topImage_bottomTitle:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2.0, left: 0.0, bottom: 0.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageWidth!, bottom: -imageHeight! - space/2.0, right: 0.0)
        case .bottomImage_topTitle:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -labelHeight - space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight! - space/2.0, left: -imageWidth!, bottom: 0.0, right: 0.0)
        case .leftImage_rightTitle:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -space/2.0, bottom: 0.0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: space/2.0, bottom: 0.0, right: -space/2.0)
        case .rightImage_leftTitle:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: labelWidth + space/2.0, bottom: 0.0, right: -labelWidth - space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageWidth! - space/2.0, bottom: 0.0, right: imageWidth! + space/2.0)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
        return self
    }
    
    @discardableResult
    func jwButtonAction(_ action: @escaping (JWButton) -> Void) -> JWButton {
        self.jw_action = action
        self.addTarget(self, action: #selector(jwButtonClick(_:)), for: UIControl.Event.touchUpInside)
        return self
    }
    
    @objc func jwButtonClick(_ button: JWButton) {
        if let action = self.jw_action {
            action(button)
        }
    }
}
