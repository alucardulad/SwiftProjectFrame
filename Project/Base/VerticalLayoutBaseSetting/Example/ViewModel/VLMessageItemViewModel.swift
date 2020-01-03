//
//  VLMessageItemViewModel.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLMessageItemViewModel: VLBaseItemViewModel {
    let msg: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var isCornerRadiusTopRight: Bool = false
    var isCornerRadiusTopLeft: Bool = false
    var isCornerRadiusBottomRight: Bool = false
    var isCornerRadiusBottomLeft: Bool = false
    
    init(msg: String) {
        super.init(itemSupportClassName: VLMessageTableViewCell.self,
                   isLine: true,
                   height: kScaleHeight(45))
        self.msg.accept(msg)
    }
    
    convenience init(topCornerMsg: String) {
        self.init(msg: topCornerMsg)
        isCornerRadiusTopLeft = true
        isCornerRadiusTopRight = true
    }
    
    convenience init(bottomCornerMsg: String) {
        self.init(msg: bottomCornerMsg)
        isCornerRadiusBottomLeft = true
        isCornerRadiusBottomRight = true
    }
    
    convenience init(allCornerMsg: String) {
        self.init(msg: allCornerMsg)
        isCornerRadiusTopLeft = true
        isCornerRadiusTopRight = true
        isCornerRadiusBottomLeft = true
        isCornerRadiusBottomRight = true
    }
}
