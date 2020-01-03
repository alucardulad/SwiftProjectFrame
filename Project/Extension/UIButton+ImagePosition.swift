//
//  UIButton+ImagePosition.swift
//  VeSync
//
//  Created by dave on 2019/12/2.
//  Copyright © 2019 Etekcity. All rights reserved.
//

public enum ButtonImagePosition: Int {
    case left
    case right
    case top
    case bottom
}

extension UIButton {

    /// 设置按键图片和文字的位置(设置或修改完文字，图片后 调用此方法)
    func placeImageTitlePosition(position: ButtonImagePosition, space: CGFloat) {

        var imageWidth: CGFloat = 0.0
        var imageHeight: CGFloat = 0.0
        if let imgView = self.imageView {
            // 获取按钮图片的宽高
            let imgSize = imgView.intrinsicContentSize
            imageWidth = imgSize.width
            imageHeight = imgSize.height
        }

        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        if let label = self.titleLabel {
            // 获取文字的宽高
            let labelSize = label.intrinsicContentSize
            labelWidth = labelSize.width
            labelHeight = labelSize.height
        }

        #if DEBUG
        print("按钮图片 width: \(imageWidth))  height: \(imageHeight))")
        print("按钮文字 width: \(labelWidth))  height: \(labelHeight))")
        print("按钮大小 width: \(frame.width))  height: \(frame.height))")
        #endif

        // 按钮图片文字的位置 EdgeInsets 都是相对原来的位置变化  类似于CSS 里的padding 往内侧方向是正
        var titleTop: CGFloat = 0.0, titleLeft: CGFloat = 0.0, titleBottom: CGFloat = 0.0, titleRight: CGFloat = 0.0
        var imageTop: CGFloat = 0.0, imageLeft: CGFloat = 0.0, imageBottom: CGFloat = 0.0, imageRight: CGFloat = 0.0

        switch (position) {
        // 图片在左、文字在右;
        case .left:
            imageTop = 0
            imageBottom = 0
            imageLeft =  -space / 2.0
            imageRight = space / 2.0

            titleTop = 0
            titleBottom = 0
            titleLeft = space / 2
            titleRight = -space / 2
        // 图片在上，文字在下
        case .top:
            imageTop = -(labelHeight / 2.0 + space / 2.0)//图片上移半个label高度和半个space高度  给label使用
            imageBottom = (labelHeight / 2.0 + space / 2.0)
            imageLeft = labelWidth / 2.0
            imageRight = -labelWidth / 2.0

            titleLeft = -imageWidth / 2.0
            titleRight = imageWidth / 2.0
            titleTop = imageHeight / 2.0 + space / 2.0//文字下移半个image高度和半个space高度
            titleBottom = -(imageHeight / 2.0 + space / 2.0)
        // 图片在右，文字在左
        case .right:
            imageTop = 0
            imageBottom = 0
            imageRight = -(labelWidth + space / 2.0)
            imageLeft = labelWidth + space / 2.0

            titleTop = 0
            titleLeft = -(imageWidth + space / 2.0)
            titleBottom = 0
            titleRight = imageWidth + space / 2.0
        // 图片在下，文字在上
        case .bottom:
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0
            imageRight = -labelWidth / 2.0
            imageBottom = -(labelHeight / 2.0 + space / 2.0)
            imageTop = labelHeight / 2.0 + space / 2.0//图片下移半个label高度和半个space高度  给label使用

            titleTop = -(imageHeight / 2.0 + space / 2.0)
            titleBottom = imageHeight / 2.0 + space / 2.0
            titleLeft = -imageWidth / 2.0
            titleRight = imageWidth / 2.0

        }

        imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
        titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)

    }
}
