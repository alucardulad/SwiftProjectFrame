//
//  JWBaseModel.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/4.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class JWBaseModel: NSObject {

}

class JWBaseDataModel: NSObject {
    
}

class JWBaseItemViewModel: NSObject {
    
    var isLine: Bool?
    var height: Double?
    var data: AnyObject?
    var isRightArrow: Bool?
    var itemSupportClassName: AnyClass!
    
    init(itemSupportClassName: AnyClass,
         isLine: Bool = false,
         height: Double = 50.0,
         data: AnyObject? = nil,
         isRightArrow: Bool = false) {
        
        self.itemSupportClassName = itemSupportClassName
        self.isLine = isLine
        self.height = height
        self.data = data
        self.isRightArrow = isRightArrow
    }
}
