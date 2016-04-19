//
//  DPPresentationController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DPPresentationController: UIPresentationController {
    
    lazy var dimmingView: DPDimmingView? = {
        guard let containerView = self.containerView else { return nil }
        return DPDimmingView.init(frame: containerView.bounds)
    }()
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard var frame = containerView?.bounds else { return CGRectZero }
        frame.size.height = 84
        
        return frame
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let dimmingView = dimmingView else { return }
        
        containerView?.insertSubview(dimmingView, atIndex: 0)
        dimmingView.alpha = 0
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) in
            dimmingView.alpha = 1
            }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView()?.frame = frameOfPresentedViewInContainerView()
        dimmingView?.frame = containerView?.bounds ?? CGRectZero
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) in
            self.dimmingView?.alpha = 0
            }, completion: nil)
    }
}