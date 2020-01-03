//
//  ModalTransitionDelegate.swift
//  VeSync
//
//  Created by dave on 2019/12/6.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

enum ModalOperation: Int {
    case present
    case dismiss
}

class ModalTransitionDelegate: NSObject {

    private var animators = [ModalOperation: UIViewControllerAnimatedTransitioning]()
    private var presentationController: UIPresentationController?

    open func set(animator: UIViewControllerAnimatedTransitioning, for operation: ModalOperation) {
        animators[operation] = animator
    }

    open func removeAnimator(for operation: ModalOperation) {
        animators.removeValue(forKey: operation)
    }

    open func set(presentationController: UIPresentationController?) {
        self.presentationController = presentationController
    }

}

extension ModalTransitionDelegate: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animators[.present]
    }

    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animators[.dismiss]
    }

    open func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return  nil
    }

    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return presentationController
    }
}
