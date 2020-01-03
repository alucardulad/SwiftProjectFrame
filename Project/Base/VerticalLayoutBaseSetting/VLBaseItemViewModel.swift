//
//  VLBaseItemViewModel.swift
//  Assureapt
//
//  Created by HET on 2019/12/25.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit
import RxSwift

class VLBaseItemViewModel: NSObject {
    
    //cell底部线
    var isLine: Bool! = false
    //cell高度
    var height: CGFloat?
    //数据对象
    var data: AnyObject?
    //右箭头
    var isRightArrow: Bool?
    //当前对应的cell
    var itemSupportClassName: AnyClass!
    //点击事件响应类型
    var selectType: AnyObject?
    //indexPath
    var indexPath: IndexPath?
    
    init(itemSupportClassName: AnyClass,
         isLine: Bool = false,
         height: CGFloat = 50.0,
         data: AnyObject? = nil,
         isRightArrow: Bool = false) {
        
        self.itemSupportClassName = itemSupportClassName
        self.isLine = isLine
        self.height = height
        self.data = data
        self.isRightArrow = isRightArrow
    }
}
