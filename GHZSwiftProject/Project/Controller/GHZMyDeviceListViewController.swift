//
//  GHZMyDeviceListViewController.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

class GHZMyDeviceListViewController: JWBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    // MARK: - viewController的周期
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    // MARK: - 点击事件配置
    override func leftBarButtonItemClick(_ button: UIButton) {
    }
    
    override func rightBarButtonItemClick(_ button: UIButton) {
    }
    // MARK: - viewController的页面配置链
    override func setupEvents() {
    }
    
    override func setupRacSignal() {
    }

    override func setupUI() {
        super.setupUI()
    }
    
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.view.addSubview(self.tableView!)
        
        self.tableView?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.jwNavigationBar.snp.bottom)
        })
    }
    
    override func setupInstance() {
        super.setupInstance()
        
        self.tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.tableFooterView = UIView()
        tableView?.backgroundColor = UIColor.clear
        tableView?.register(GHZStatusTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    
    override func setupNaviegationBar() {
        self.jwSetLeftBarItemImage(UIImage(named: "shop_icon"))
        self.jwSetRightBarItemImage(UIImage(named: "add_icon"))
        self.jwSetNavigationBar(title: "我的设备")
    }
    // MARK: - 协议实现 - tablview的delegate和DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(JWMacro.frame_base_height(14.0))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(JWMacro.frame_base_height(72.0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = GHZMyDeviceListViewController()
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
