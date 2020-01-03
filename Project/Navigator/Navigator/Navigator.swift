//
//  Navigator.swift
//  VeSync
//
//  Created by dave on 2019/11/6.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import Foundation

protocol Navigatable {
    var navigator: Navigator? { get set }
}

protocol SceneType {
    func getVC() -> UIViewController?
}

class Navigator {

    enum Transition {
        case navigation
        case modal
        case modalFromTop
    }

    lazy var modalTransition: ModalTransitionDelegate = {
        let modalTransitionDelegate = ModalTransitionDelegate()
        modalTransitionDelegate.set(animator: TopPresentAnimator(), for: .present)
        modalTransitionDelegate.set(animator: TopDismissAnimator(), for: .dismiss)
        return modalTransitionDelegate
    }()

    @discardableResult
    func show(segue: SceneType, sender: UIViewController?, transition: Transition, animated: Bool = true) -> UIViewController? {
        guard let target = segue.getVC() else { return nil }
        if let targetVC = target as? UINavigationController,
            var root = targetVC.viewControllers.first as? Navigatable {
            // 如果是导航控制器，获取根控制器 如果实现Navigatable协议，注入导航
            root.navigator = self
        } else if var targetVC = target as? Navigatable {
            // 如果实现Navigatable协议，注入导航
            targetVC.navigator = self
        }
        switch transition {
        case .navigation:
            if let nav = sender?.navigationController {
                nav.pushViewController(target, animated: animated)
            }
        case .modal:
            sender?.present(target, animated: animated, completion: nil)
        case .modalFromTop:
            target.modalPresentationStyle = .fullScreen
            target.transitioningDelegate = modalTransition
            sender?.present(target, animated: animated, completion: nil)
        }
        return target
    }

    func pop(sender: UIViewController?, toRoot: Bool = false, animated: Bool = true, targetVC: UIViewController? = nil) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: animated)
            return
        }
        if let popVC = targetVC {
            sender?.navigationController?.popToViewController(popVC, animated: animated)
            return
        }
        sender?.navigationController?.popViewController(animated: animated)
    }

    func dismiss(sender: UIViewController?, animated: Bool = true) {
        sender?.dismiss(animated: animated, completion: nil)
    }
    
    /// 获取当前栈内指定类型VC数组
    /// - Parameter sender: 当前VC
    /// - Parameter vcClass: 指定VC类
    func getStackViewControllers(sender: UIViewController?, vcClass: AnyClass) -> [UIViewController] {
        var classViewControllers: [UIViewController] = []
        sender?.navigationController?.viewControllers.forEach({ (viewController) in
            if viewController.isKind(of: vcClass) {
                classViewControllers.append(viewController)
            }
        })
        return classViewControllers
    }
    
}
