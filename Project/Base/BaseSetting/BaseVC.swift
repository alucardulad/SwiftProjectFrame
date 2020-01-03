//
//  BaseVC.swift
//  VeSync
//
//  Created by Sheldon on 2019/8/6.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol MVVMable {
    var viewModel: BaseVM? { get set }
    func bindViewModel()
}

class BaseVC: UIViewController, Navigatable, MVVMable {
    /// Rx资源回收包
    let disposeBag = DisposeBag()
    var viewModel: BaseVM?
    /// 导航器
    var navigator: Navigator?
    /// 导航栏显示
    var isHiddenNavBar = false
    /// 电池栏颜色 默认黑色
    var isLightStatusBar = false
    /// 当前控制器电池栏状态
    private var shouldStatusBarStyle: UIStatusBarStyle = .lightContent
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
        viewModel = createViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 处理需要电池栏为白色的控制器
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = isLightStatusBar ? .lightContent : .darkContent
        } else {
            UIApplication.shared.statusBarStyle = isLightStatusBar ? .lightContent : .default
        }
        // 处理需要隐藏导航栏的控制器
        navigationController?.setNavigationBarHidden(isHiddenNavBar, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logResourcesCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavicationBarStyle()
        setNavigationBar()
        setupUI()
        bindViewModel()
    }
    
    func setNavigationBar() { }
    
    func setupUI() {
        view.backgroundColor = kMainLgihtGray
    }

    /// 子类重写
    func createViewModel() -> BaseVM? {
        return nil
    }
    
    func bindViewModel() {
        // 通用的错误处理，warning: 重要
        viewModel?.error.asDriver().drive(onNext: { (error) in
            if let error: LocalizedError = error as? LocalizedError {
                SVProgressHUD.showError(withStatus: error.errorDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func clickBack() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        logDebug("deinit: \(type(of: self))")
        logResourcesCount()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logDebug("\(type(of: self)): Received Memory Warning")
    }
}

// MARK: - 基本配置
extension BaseVC {
    
    private func setNavicationBarStyle() {
        guard navigationController != nil else {
            return
        }
    }
}

// MARK: - 手势处理
extension BaseVC: UIGestureRecognizerDelegate {
    
    /// 判断情况禁用手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController else {
            return false
        }
        let isRootVC = navigationController.viewControllers.count > 1
        return isRootVC
    }
    
    /// 点击屏幕停止编辑
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}
