//
//  VLBaseViewModel.swift
//  Assureapt
//
//  Created by HET on 2019/12/25.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

typealias VLItemList = [VLBaseItemViewModel]

class VLBaseViewModel: BaseVM {
    //数据源
    var items: [VLItemList]?
    override init() {
        super.init()
        
        configurateInstance()
    }
}

extension VLBaseViewModel {
    
    @objc func configurateInstance() {
        
    }
}
