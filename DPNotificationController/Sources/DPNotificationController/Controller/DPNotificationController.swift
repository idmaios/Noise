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
    
    class func findTopViewController() -> UIViewController? {
        guard let delegate = UIApplication.sharedApplication().delegate else { return nil }
        guard let aWindow = delegate.window else { return nil }
        guard let bWindow = aWindow else { return nil }
        guard var topViewController = bWindow.rootViewController else { return nil }
        
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        return topViewController
    }

    
    var showingInFixedViewController = false
    weak var fixedViewController: UIViewController?
    
    lazy var viewController: UIViewController? = {
        return DPNotificationViewController.findTopViewController()
    }()
    
    private let DPNotificationViewDefaultAnimationTime = 0.3
    private let swipeGesture = UISwipeGestureRecognizer()
    
    private var view: UIView!
    private var pred: dispatch_once_t = 0
    private var viewCreationClosure: ((CGSize) -> UIView)
    private weak var notificationOperation: DPNotificationViewOperation?
    
    
    public init(viewCreationClosure closure: (CGSize) -> UIView) {
        swipeGesture.direction = .Up
        viewCreationClosure    = closure
        swipeGesture.addTarget(self, action: #selector(closeNotification))
    }
    
    //MARK: - Showing
    @objc func closeNotification(animated isAnimated: Bool = true) {
        guard let _ = view.superview else { return }
        
        dispatch_once(&pred) { [unowned self] in
            self.animatePresentation(presentation: false, animated: isAnimated) { [unowned self] finished in
                self.view.removeFromSuperview()
                self.finishNotification()
            }
        }
    }
    
    private func finishNotification() {
        guard let operation = self.notificationOperation where operation.cancelled == false else { return }
        operation.completeOperation()
    }
    
    func showNotification() {
        guard !showingInFixedViewController || fixedViewController != nil else { finishNotification(); return }
        guard let controller = fixedViewController ?? viewController else { finishNotification(); return }
        guard controller == viewController else { finishNotification(); return }
        
        viewController = controller
        
        view = viewCreationClosure(controller.view.frame.size)
        
        view.autoresizingMask = [.FlexibleWidth]
        controller.view.addSubview(view)
        view.addGestureRecognizer(swipeGesture)
        
        animatePresentation(presentation: true) { finished in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.closeNotification()
            }
        }
    }
    
    func animatePresentation(presentation presentation: Bool, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        
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
    
    public func show(inFixedViewController controller: UIViewController? = nil) {
        
        fixedViewController = controller
        showingInFixedViewController = controller != nil
        
        let operation = DPNotificationViewOperation(notificationController: self)
        notificationOperation = operation
        DPNotificationManager.manager.addPresentationOperation(operation)
    }
}
