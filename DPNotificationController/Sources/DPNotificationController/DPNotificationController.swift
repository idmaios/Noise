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

public class DPNotificationController: UIViewController {
    
    let message: String
    let icon: UIImage?
    let transitionDelegate = DPPresentationDelegate()
    let swipeGesture = UISwipeGestureRecognizer()
    
    weak var notificationOperation: DPNotificationViewOperation?
    
    
    public init(message: String, icon: UIImage? = nil) {
        self.message = message
        self.icon    = icon
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .Custom
        transitioningDelegate  = transitionDelegate
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.message = ""
        self.icon    = nil
        
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        swipeGesture.direction = .Up
        swipeGesture.addTarget(self, action: #selector(closeNotification))
        view.addGestureRecognizer(swipeGesture)
        
        view.backgroundColor = UIColor.greenColor()
        switch flag {
        case 1: view.backgroundColor = UIColor.redColor()
        case 2: view.backgroundColor = UIColor.greenColor()
        case 3: view.backgroundColor = UIColor.purpleColor()
        case 4: view.backgroundColor = UIColor.yellowColor()
        case 5: view.backgroundColor = UIColor.whiteColor()
        case 6: view.backgroundColor = UIColor.blueColor()
        case 7: view.backgroundColor = UIColor.magentaColor()
        default: break
        }
        flag += 1
    }
    
    func showNotification() {
        
        guard let delegate = UIApplication.sharedApplication().delegate else { return }
        guard let aWindow = delegate.window else { return }
        guard let bWindow = aWindow else { return }
        guard let rootViewController = bWindow.rootViewController else { return }
        
        var topViewController = rootViewController
        
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        topViewController.presentViewController(self, animated: true) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(flag) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.closeNotification()
            }
        }
    }
    
    func closeNotification() {
        guard let _ = presentingViewController else { return }
        
        dismissViewControllerAnimated(true) {
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
