//
//  BannerTransition.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/20/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class PopupShowAnimator : NSObject, UIViewControllerAnimatedTransitioning {

    // This is used for percent driven interactive transitions, as well as for
    // container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        if let toView = transitionContext.view(forKey: UITransitionContextViewKey.to),
            let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let tabController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? BaseTabViewController {
            containerView.addSubview(toView)
            tabController.view.insertSubview(containerView, belowSubview:tabController.tabBar)
            
            if let coordinator = toController.transitionCoordinator {
                coordinator.animateAlongsideTransition(in: tabController.view, animation: { (context) in
                    tabController.bannerView.frame.origin.y = 0.0 - BannerViewConstants.viewHeight
                    tabController.tabBar.frame.origin.y += tabController.tabBar.frame.size.height
                }, completion:  nil)
            }
            
            toView.frame.origin.y = toView.frame.height - tabController.tabBar.frame.height
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                toView.frame.origin.y = 0.0
            }, completion: { (finished) in
                let success = !transitionContext.transitionWasCancelled
                
                transitionContext.completeTransition(success)
            })
            
        }
    }
}

class PopupDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let tabController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? BaseTabViewController {
            containerView.addSubview(fromView)
            tabController.view.insertSubview(containerView, belowSubview:tabController.tabBar)
            
            if let coordinator = fromController.transitionCoordinator {
                coordinator.animateAlongsideTransition(in: tabController.view, animation: { (context) in
                    tabController.bannerView.frame.origin.y = tabController.view.frame.height - tabController.tabBar.frame.height - BannerViewConstants.viewHeight
                    tabController.tabBar.frame.origin.y -= tabController.tabBar.frame.size.height
                }, completion: nil)
            }
            
            fromView.frame.origin.y = 0.0
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                fromView.frame.origin.y = fromView.frame.height - tabController.tabBar.frame.height
            }, completion: { (finished) in
                let success = !transitionContext.transitionWasCancelled
                
                transitionContext.completeTransition(success)
            })
            
        }
    }
}
