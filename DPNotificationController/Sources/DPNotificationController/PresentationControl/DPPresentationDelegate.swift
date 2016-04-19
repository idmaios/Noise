//
//  DPPresentationDelegate.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DPPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    @objc func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return DPPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    @objc func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPPresentationAnimtor(presentation: true)
    }
    
    @objc func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPPresentationAnimtor(presentation: false)
    }
}
