//
//  VLFunctionViewController.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLFunctionViewController: VLBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    override func rightBarButtonItemClick(_ button: UIButton) {
        
    }
    
    override func tableViewDidSelect(item: VLBaseItemViewModel?, indexPath: IndexPath) {
        switch item?.selectType {
            
        default: break
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
}

extension VLFunctionViewController {
    // MARK: - 事件配置
    override func configurateEvents() {
        super.configurateEvents()

    }
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()
        
    }
    // MARK: - addsubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
    }
    // MARK: - 实例化对象
    override func configurateInstance() {
        super.configurateInstance()
        
    }
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
    }
}
