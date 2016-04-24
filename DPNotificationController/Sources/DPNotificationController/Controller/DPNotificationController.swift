//
//  DPNotificationController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

public class DPNotificationViewController {

    var view: UIView!
    
    private var pred: dispatch_once_t = 0
    private let DPNotificationViewDefaultAnimationTime = 0.3
    
    private let swipeGesture = UISwipeGestureRecognizer()
    private weak var notificationOperation: DPNotificationViewOperation?
    
    private let topViewController: UIViewController!
    
    internal lazy var maxSize: CGSize = {
        return self.topViewController!.view.frame.size
    }()
    
    class private func findTopViewController() -> UIViewController? {
        guard let delegate = UIApplication.sharedApplication().delegate else { return nil }
        guard let aWindow = delegate.window else { return nil }
        guard let bWindow = aWindow else { return nil }
        guard var topViewController = bWindow.rootViewController else { return nil }
        
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        return topViewController
    }
    
    
    public init?() {
        guard let controller = DPNotificationViewController.findTopViewController() else { return nil }
        
        topViewController = controller
        swipeGesture.direction = .Up
        swipeGesture.addTarget(self, action: #selector(closeNotification))
    }
    
    //MARK: - Showing
    @objc func closeNotification() {
        guard let _ = view.superview else { return }
        
        dispatch_once(&pred) { [unowned self] in
            self.animatePresentation(presentation: false) { [unowned self] finished in
                self.view.removeFromSuperview()
                
                guard let operation = self.notificationOperation where operation.cancelled == false else { return }
                operation.completeOperation()
            }
        }
    }
    
    func showNotification() {
    
        view.autoresizingMask = [.FlexibleWidth]
        topViewController.view.addSubview(view)
        view.addGestureRecognizer(swipeGesture)
        
        animatePresentation(presentation: true) { finished in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.closeNotification()
            }
        }
    }
    
    func animatePresentation(presentation presentation: Bool, completion: ((Bool) -> Void)? = nil) {
        
        if presentation {
            var newFrame = view.frame
            newFrame.origin.y = -newFrame.size.height
            view.frame = newFrame
        }
        
        UIView.animateWithDuration(DPNotificationViewDefaultAnimationTime, delay: 0, options: .TransitionNone, animations: { [unowned self] in
            var newFrame = self.view.frame
            newFrame.origin.y = presentation ? 0 : -newFrame.size.height
            self.view.frame = newFrame
            
        }, completion: completion)
    }
    
    public func show() {
        
        let operation = DPNotificationViewOperation(notificationController: self)
        notificationOperation = operation
        DPNotificationManager.manager.addPresentationOperation(operation)
    }
}
