//
//  BannerPanInteractiveTransition.swift
//  DiningMode
//
//  Created by Adrian Cheng on 8/19/17.
//  Copyright © 2017 OpenTable, Inc. All rights reserved.
//

import UIKit

class BannerInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    public func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if let parentView = gesture.view?.superview {
            
            let translation = gesture.translation(in: parentView).y
            let percentage = min(max(0.0 - translation / (parentView.frame.height - 50.0), 0.0), 1.0)
            
            switch gesture.state {
            case .began:
                gesture.setTranslation(.zero, in: parentView)
                break
            case .changed:
                    update(percentage)
                break
            case .ended:
                if (percentage < 0.5) {
                    cancel()
                } else {
                    finish()
                }
                break
            case .cancelled:
                cancel()
                break
            case .failed:
                cancel()
                break
            default:
                break
            }
        }
    }
    
}
