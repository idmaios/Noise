//
//  NosieController.swift
//  Noise
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

public class NoiseController {
    static let NoiseDefaultAnimationTime = 0.3
    
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
    
    class func findTopViewControllerInNavigationController() -> UIViewController? {
        guard let topController = NoiseController.findTopViewController() else { return nil }
        guard let navigationController = topController as? UINavigationController else { return topController }
        
        return navigationController.viewControllers.last ?? nil
    }

    
    var showingInFixedViewController = false
    weak var fixedViewController: UIViewController?
    
    lazy var topViewController: UIViewController? = {
        return NoiseController.findTopViewController()
    }()
    
    lazy var topViewControllerInNavigationController: UIViewController? = {
        guard let navigationController = self.topViewController as? UINavigationController else { return self.topViewController }
        return navigationController.viewControllers.last ?? nil
    }()
    
    private let swipeGesture = UISwipeGestureRecognizer()
    
    private var showDuration: Double?
    private var view: UIView!
    private var pred: dispatch_once_t = 0
    private var viewCreationClosure: ((maxSize: CGSize, topOffset: CGFloat) -> UIView)
    private weak var notificationOperation: NoiseOperation?
    
    
    public init(viewCreationClosure closure: (CGSize, CGFloat) -> UIView) {
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
        guard let controller = fixedViewController ?? topViewController else { finishNotification(); return }
        guard controller == topViewController || controller == topViewControllerInNavigationController else { finishNotification(); return }
        topViewController = controller
        
        var topOffset = topViewController?.topLayoutGuide.length ?? 0
        if let viewController = topViewController?.navigationController where !viewController.navigationBarHidden {
            topOffset = 0
        }
        
        view = viewCreationClosure(maxSize: controller.view.frame.size, topOffset: topOffset)
        
        view.autoresizingMask = [.FlexibleWidth]
        controller.view.addSubview(view)
        view.addGestureRecognizer(swipeGesture)
        
        animatePresentation(presentation: true) { [unowned self] finished in
            guard let duration = self.showDuration else { return }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
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
        
        var y: CGFloat = 0
        
        if let viewController = topViewController?.navigationController where !viewController.navigationBarHidden && viewController.navigationBar.translucent {
            y = CGRectGetMaxY(viewController.navigationBar.frame)
        }
        
        UIView.animateWithDuration(NoiseController.NoiseDefaultAnimationTime, delay: 0, options: .TransitionNone, animations: { [unowned self] in
            var newFrame = self.view.frame
            newFrame.origin.y = presentation ? y : -newFrame.size.height
            self.view.frame = newFrame
            
        }, completion: completion)
    }
    
    public func show(inFixedViewController controller: UIViewController? = nil, duration: Double? = Noise.DefaultNotificationDuration) {

        fixedViewController = controller
        showingInFixedViewController = controller != nil
        showDuration = duration
        
        let operation = NoiseOperation(notificationController: self)
        notificationOperation = operation
        NoiseManager.manager.addPresentationOperation(operation)
    }
}
