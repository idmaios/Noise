//
//  DPPresentationAnimtor.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DPPresentationAnimtor: NSObject, UIViewControllerAnimatedTransitioning {
    
    let DPPresentationAnimtorTransitionDuration = 0.3
    let presentation: Bool
    
    
    init(presentation: Bool) {
        self.presentation = presentation
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return DPPresentationAnimtorTransitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let notificationController = presentation ? transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) : transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else { return }
        
        let containerView = transitionContext.containerView()
        
        notificationController.view.frame = transitionContext.finalFrameForViewController(notificationController)
        notificationController.view.layoutIfNeeded()
        
        if presentation {
            var newFrame = notificationController.view.frame
            newFrame.origin.y = -newFrame.size.height
            notificationController.view.frame = newFrame
            
            containerView?.addSubview(notificationController.view)
        }
        
        UIView.animateWithDuration(DPPresentationAnimtorTransitionDuration, delay: 0, options: .TransitionNone, animations: { 
            var newFrame = notificationController.view.frame
            newFrame.origin.y = self.presentation ? 0 : -newFrame.size.height
            notificationController.view.frame = newFrame
            
        }) { (finished) in transitionContext.completeTransition(true) }
    }
}
