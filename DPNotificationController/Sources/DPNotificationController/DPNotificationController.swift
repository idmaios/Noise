//
//  DPNotificationController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

var flag = 1

public class DPNotificationView: UIView {

    private let DPNotificationViewDefaultAnimationTime = 0.3
    
    private let swipeGesture = UISwipeGestureRecognizer()
    private weak var notificationOperation: DPNotificationViewOperation?
    
    private let message: String
    private let icon: UIImage?
    
    private var topViewController: UIViewController? {
        get {
            guard let delegate = UIApplication.sharedApplication().delegate else { return nil }
            guard let aWindow = delegate.window else { return nil }
            guard let bWindow = aWindow else { return nil }
            guard var topViewController = bWindow.rootViewController else { return nil }
            
            while (topViewController.presentedViewController != nil) {
                topViewController = topViewController.presentedViewController!
            }
            
            return topViewController
        }
    }
    
    
    public init(message: String, icon: UIImage? = nil) {
        self.message = message
        self.icon    = icon
        
        super.init(frame: CGRectZero)
        
        swipeGesture.direction = .Up
        swipeGesture.addTarget(self, action: #selector(closeNotification))
        addGestureRecognizer(swipeGesture)   
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        switch flag % 7 {
            case 0: backgroundColor = UIColor.magentaColor()
            case 1: backgroundColor = UIColor.redColor()
            case 2: backgroundColor = UIColor.greenColor()
            case 3: backgroundColor = UIColor.purpleColor()
            case 4: backgroundColor = UIColor.yellowColor()
            case 5: backgroundColor = UIColor.whiteColor()
            case 6: backgroundColor = UIColor.blueColor()
            default: break
        }
        
        guard let _ = superview else { return }
        flag += 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.message = ""
        self.icon    = nil
        
        super.init(coder: aDecoder)
    }
    
    func showNotification() {
        guard let topViewController = topViewController else { return }
        
        frame = CGRect(origin: CGPointZero, size: CGSize(width: topViewController.view.frame.width, height: 100))
        layoutIfNeeded()
        topViewController.view.addSubview(self)
        
        animatePresentation(presentation: true) { finished in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(flag) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.closeNotification()
            }
        }
    }
    
    func animatePresentation(presentation presentation: Bool, completion: ((Bool) -> ())? = nil) {
        
        if presentation {
            var newFrame = self.frame
            newFrame.origin.y = -newFrame.size.height
            self.frame = newFrame
        }
        
        UIView.animateWithDuration(DPNotificationViewDefaultAnimationTime, delay: 0, options: .TransitionNone, animations: {
            var newFrame = self.frame
            newFrame.origin.y = presentation ? 0 : -newFrame.size.height
            self.frame = newFrame
            
        }, completion: completion)
    }
    
    func closeNotification() {
        guard let _ = superview else { return }
        
        animatePresentation(presentation: false) { finished in
            self.removeFromSuperview()
            
            guard let operation = self.notificationOperation where operation.cancelled == false else { return }
            operation.completeOperation()
        }
    }
    
    public func show() {
        
        let operation = DPNotificationViewOperation(notificationController: self)
        notificationOperation = operation
        DPNotificationManager.manager.addPresentationOperation(operation)
    }
}
