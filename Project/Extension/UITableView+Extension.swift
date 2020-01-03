//
//  UITableView+Extension.swift
//  VeSync
//
//  Created by Sheldon on 2019/9/28.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

extension UITableView {
    
    func noDataHandle(isHidden: Bool, type: NoDataType) {
        if isHidden {
            tableFooterView = UIView()
            return
        }
        tableFooterView = NoDataDefaultView(frame: frame, type: type)
    }
    
}

extension Reactive where Base: UITableView {
    func noDataDefaultHidden() -> Binder<(Bool, NoDataType)> {
        return Binder(self.base, binding: { (tableView, arg) in
            let (isHidden, type) = arg
            if isHidden {
                tableView.tableFooterView = UIView()
                return
            }
            tableView.tableFooterView = NoDataDefaultView(frame: tableView.frame, type: type)
        })
    }
}
