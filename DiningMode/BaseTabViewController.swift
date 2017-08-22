//
//  BaseTabViewController.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/20/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

struct BannerViewConstants {
    static let viewHeight : CGFloat = 50.0
}

class BaseTabViewController: UITabBarController, UIViewControllerTransitioningDelegate {
    let bannerView = UIView()
    let interactiveTransition = BannerInteractiveTransition()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupBannerView()
    }
    
    private func setupBannerView() {
        // Banner
        bannerView.backgroundColor = .magenta // Debug colors
        
        bannerView.frame = CGRect(x: 0.0,
                                  y: self.view.frame.height - self.tabBar.frame.height - BannerViewConstants.viewHeight,
                                  width: self.view.frame.width,
                                  height: BannerViewConstants.viewHeight);
        
        view.insertSubview(bannerView, belowSubview: tabBar)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        bannerView.gestureRecognizers = [tapGesture, panGesture]
    }
    
    
    // MARK: Presentations
    
    private func showDiningMode() {
        let diningViewController = DiningModeViewController()
        let navigationController = UINavigationController.init(rootViewController: diningViewController)
        
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.transitioningDelegate = self
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    // MARK: Gesture Handles
    
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        showDiningMode()
        
        interactiveTransition.finish()
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if (gesture.state == .began) {
            showDiningMode()
        }
        
        interactiveTransition.handlePanGesture(gesture: gesture)
    }
    
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopupShowAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopupDismissAnimator()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }

    
}
