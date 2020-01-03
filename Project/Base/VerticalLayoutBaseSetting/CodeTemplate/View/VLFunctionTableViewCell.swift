//
//  VLFunctionTableViewCell.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLFunctionTableViewCell: VLBaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //数据填充以及处理
    override func bind(to itemViewModel: VLBaseItemViewModel?) {
        super.bind(to: itemViewModel)
        
    }
}

extension VLFunctionTableViewCell {
    // MARK: - Cell的页面配置链
    override func configurateEvents() {
        super.configurateEvents()
        
    }
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
    }
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
    }
}
