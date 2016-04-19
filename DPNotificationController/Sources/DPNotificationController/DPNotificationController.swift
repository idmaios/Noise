//
//  DPNotificationController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DPNotificationController: UIViewController {
    
    let message: String
    let icon: UIImage?
    let transitionDelegate = DPPresentationDelegate()
    let swipeGesture = UISwipeGestureRecognizer()
    
    
    init(message: String, icon: UIImage? = nil) {
        self.message = message
        self.icon    = icon
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .Custom
        transitioningDelegate  = transitionDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.message = ""
        self.icon    = nil
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeGesture.direction = .Up
        swipeGesture.addTarget(self, action: #selector(closeNotification))
        view.addGestureRecognizer(swipeGesture)
        
        view.backgroundColor = UIColor.redColor()
    }
    
    func closeNotification() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func show() {
        guard let delegate = UIApplication.sharedApplication().delegate else { return }
        guard let aWindow = delegate.window else { return }
        guard let bWindow = aWindow else { return }
        guard let rootViewController = bWindow.rootViewController else { return }
        
        var topViewController = rootViewController
        
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        topViewController.presentViewController(self, animated: true) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.closeNotification()
            }
        }
    }
}
