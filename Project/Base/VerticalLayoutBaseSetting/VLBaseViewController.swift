//
//  VLBaseViewController.swift
//  Assureapt
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VLBaseViewController: BaseVC {
    
    var tableView: UITableView?
    var bgImageView: UIImageView!
    var navigationBar: VLNavigationBarView!
    
    // MARK: - viewController的周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurateUI()
        self.configurateEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(self.navigationBar)
    }
    
    deinit {
        print("")
        print("")
        print("页面释放了\(self.classForCoder)")
        print("")
        print("")
    }
}

// MARK: - viewController控制器配置链
extension VLBaseViewController {
    
    @objc func configurateEvents() {
        
    }
    
    @objc func configurateUI() {
        self.configurateInstance()
        self.layoutUIInstance()
        self.configurateNavigationBar()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor? = VLConst.kHexColor(0xefeff4)
    }
    
    @objc func layoutUIInstance() {
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(tableView!)
        
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        
        tableView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.navigationBar.snp_bottom)
        })
    }
    
    @objc func configurateInstance() {
        self.bgImageView = UIImageView()
        
        self.navigationBar = VLNavigationBarView(theSuperView: self.view)
        navigationBar.setStatusBarBackgroundColor(UIColor.white)
        navigationBar.setNavigationBarBackgroundColor(UIColor.white)
        
        self.tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.tableFooterView = UIView()
        tableView?.backgroundColor = UIColor.clear
        VLGlobalUseCellSet.registerCell(tableView: tableView!)
    }
    
    @objc func configurateNavigationBar() {
        
    }
}
// MARK: - navigationBar自定义配置
extension VLBaseViewController {
    
    @objc func leftBarButtonItemClick(_ button: UIButton) {
        self.navigator?.pop(sender: self)
    }
    
    @objc func rightBarButtonItemClick(_ button: UIButton) {
        
    }
    
    @objc func tableViewDidSelect(item: VLBaseItemViewModel?, indexPath: IndexPath) {
        
    }

    func setTitle(title: String,
                  titleColor: UIColor = VLConst.kHexColor(0x323232),
                  font: UIFont = UIFont.systemFont(ofSize: 17.0)) {
        self.navigationBar.setTitle(title,
                                    textColor: titleColor,
                                    textFont: font)
    }
    
    func setLeftBarItem(text: String,
                        color: UIColor = UIColor.black,
                        font: UIFont = UIFont.systemFont(ofSize: 15.0)) {
        self.navigationBar.setLeftItem(text: text,
                                       color: color,
                                       font: font,
                                       target: self,
                                       method: #selector(leftBarButtonItemClick(_:)))
    }
    
    func setRightBarItem(text: String,
                         color: UIColor = UIColor.black,
                         font: UIFont = UIFont.systemFont(ofSize: 15.0)) {
        self.navigationBar.setRightItem(text: text,
                                        color: color,
                                        font: font,
                                        target: self,
                                        method: #selector(rightBarButtonItemClick(_:)))
    }
    
    func setLeftBarItemImage(_ image: UIImage?) {
        self.navigationBar.setLeftItemImage(image: image,
                                            target: self,
                                            action: #selector(leftBarButtonItemClick(_:)))
    }
    
    func setRightBarItemImage(_ image: UIImage?) {
        self.navigationBar.setRightItemImage(image: image,
                                             target: self,
                                             action: #selector(rightBarButtonItemClick(_:)))
    }
}
// MARK: - tableView的Delegate
extension VLBaseViewController: UITableViewDelegate {
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let baseModel = viewModel as? VLBaseViewModel {
            let item = baseModel.items?[indexPath.section][indexPath.row]
            return item?.height ?? 0.0
        }
        return 0.0
    }
    
    @objc func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    @objc func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kScaleHeight(10)
    }
    
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let baseModel = viewModel as? VLBaseViewModel {
            let item = baseModel.items?[indexPath.section][indexPath.row]
            tableViewDidSelect(item: item, indexPath: indexPath)
        }
    }
    
    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
// MARK: - tableView的DataSource
extension VLBaseViewController: UITableViewDataSource {
    @objc func numberOfSections(in tableView: UITableView) -> Int {
        if let baseModel = viewModel as? VLBaseViewModel {
            return baseModel.items?.count ?? 0
        }
        return 0
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let baseModel = viewModel as? VLBaseViewModel {
            if let list = baseModel.items?[section] {
                return list.count
            }
        }
        return 0
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let baseModel = viewModel as? VLBaseViewModel {
            let itemViewModel = baseModel.items?[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(itemViewModel!.itemSupportClassName))
            if let cell = cell as? VLBaseTableViewCell {
                //item indexPath数据填充
                itemViewModel?.indexPath = indexPath
                //cell数据填充
                cell.bind(to: itemViewModel)
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
}
