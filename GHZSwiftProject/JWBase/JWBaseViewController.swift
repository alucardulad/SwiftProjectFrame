//
//  JWBaseViewController.swift
//  GHZSwiftProject
//
//  Created by HET on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit
import SnapKit

class JWBaseViewController: UIViewController {
    
    var bgImageView: UIImageView!
    var jwNavigationBar: JWNavigationBarView!
    
    // MARK: - 功能处理
    func jwSetNavigationBar(title: String, titleColor: UIColor = JWMacro.JWUIColorFromRGB(0x323232), font: UIFont = UIFont.systemFont(ofSize: 17.0)) {
        self.jwNavigationBar.setTitle(title, textColor: titleColor, textFont: font)
    }
    
    func jwSetLeftBarItem(text: String, color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 15.0)) {
        self.jwNavigationBar.setLeftItem(text: text, color: color, font: font, target: self, method: #selector(leftBarButtonItemClick(_:)))
    }
    
    func jwSetRightBarItem(text: String, color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 15.0)) {
        self.jwNavigationBar.setRightItem(text: text, color: color, font: font, target: self, method: #selector(rightBarButtonItemClick(_:)))
    }
    
    func jwSetLeftBarItemImage(_ image: UIImage?) {
        self.jwNavigationBar.setLeftItemImage(image: image, target: self, action: #selector(leftBarButtonItemClick(_:)))
    }
    
    func jwSetRightBarItemImage(_ image: UIImage?) {
        self.jwNavigationBar.setRightItemImage(image: image, target: self, action: #selector(rightBarButtonItemClick(_:)))
    }
    // MARK: - viewController的周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupEvents()
        self.setupRacSignal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(self.jwNavigationBar)
    }
    // MARK: - 点击事件配置
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func leftBarButtonItemClick(_ button: UIButton) {
        
    }
    
    @objc func rightBarButtonItemClick(_ button: UIButton) {
        
    }
    // MARK: - viewController的页面配置链
    func setupEvents() {
        
    }
    
    func setupRacSignal() {
        
    }
    
    func setupUI() {
        self.setupInstance()
        self.layoutUIInstance()
        self.setupNaviegationBar()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor? = JWMacro.JWUIColorFromRGB(0xefeff4)
    }
    
    func layoutUIInstance() {
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.jwNavigationBar)
        
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
    }
    
    func setupInstance() {
        self.bgImageView = UIImageView(image: UIImage(named: "login_bg"))
        self.jwNavigationBar = JWNavigationBarView(superView: self.view)
        jwNavigationBar.setStatusBarBackgroundColor(UIColor.white)
        jwNavigationBar.setNavigationBarBackgroundColor(UIColor.white)
    }
    
    func setupNaviegationBar() {
        
    }
    
    // MARK: - 协议实现
    // MARK: - viewcontroller实例释放
    deinit {
        print("")
        print("")
        print("页面释放了\(self.classForCoder)")
        print("")
        print("")
    }
}
