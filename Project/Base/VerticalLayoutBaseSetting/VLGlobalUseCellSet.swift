//
//  VLGlobalUseCellSet.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

enum VLBaseGlobalSelectType {
    case defalutType
    case accountType
    case messageType
}

struct VLGlobalUseCellSet {
    
    private static let cellNameList: [AnyClass] = [UITableViewCell.self,
                                                   VLAccountTableViewCell.self,
                                                   VLMessageTableViewCell.self]
    //注册使用的cell
    static func registerCell(tableView: UITableView) {
        for theClass in VLGlobalUseCellSet.cellNameList {
            tableView.register(theClass, forCellReuseIdentifier: NSStringFromClass(theClass))
        }
    }
}
