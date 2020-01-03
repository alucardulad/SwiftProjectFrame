//
//  TopDismissAnimator.swift
//  VeSync
//
//  Created by dave on 2019/12/6.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class TopDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.5
        containerView.addSubview(toViewController.view)
        containerView.sendSubviewToBack(toViewController.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            let bounds = UIScreen.main.bounds
            fromViewController.view.frame = fromViewController.view.frame.offsetBy(dx: 0, dy: -bounds.size.height)
            toViewController.view.alpha = 1.0
        }, completion: { _ in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
