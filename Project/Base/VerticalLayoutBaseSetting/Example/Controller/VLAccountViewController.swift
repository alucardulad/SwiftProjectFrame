//
//  VLAccountViewController.swift
//  Assureapt
//
//  Created by HET on 2019/12/26.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VLAccountViewController: VLBaseViewController {
    
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
        
        if let item = (item as? VLMessageItemViewModel) {
            print((item.msg.value ?? "") + "点击")
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard (viewModel as? VLAccountViewModel) != nil  else {
            return
        }
        
        let viewModel = self.viewModel as! VLAccountViewModel
        
        viewModel.accountSubject.subscribe { (_) in
            print("头像点击")
        }.disposed(by: disposeBag)
        viewModel.makeMoneySubject.subscribe { (_) in
            print("余额点击")
        }.disposed(by: disposeBag)
        viewModel.integrationSubject.subscribe { (_) in
            print("积分点击")
        }.disposed(by: disposeBag)
    }
}

extension VLAccountViewController {
    // MARK: - 事件配置
    override func configurateEvents() {
        super.configurateEvents()
        
    }
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()
        
        self.bgImageView.image = UIImage(named: "login_bg")
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
        self.setTitle(title: "个人中心".localized)
        self.setRightBarItemImage(UIImage(named: "message_icon"))
    }
}
