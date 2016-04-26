//
//  DPNotificationManager.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation

public class DPNotificationManager {
    public static let manager = DPNotificationManager()
    
    private let operationQueue = NSOperationQueue.mainQueue()
    
    func addPresentationOperation(operation: DPNotificationViewOperation) {
        operationQueue.addOperation(operation)
        
        let ops = operationQueue.operations.filter { $0 is DPNotificationViewOperation } as! [DPNotificationViewOperation]
        let deadOps = ops.filter { $0.notificationController.showingInFixedViewController && $0.notificationController.fixedViewController == nil }
        
        for op in deadOps {
            op.cancel()
        }
        
        let executingOps = ops.filter { $0.executing }
        guard !executingOps.isEmpty else { return }
        
        let currentOperation = ops[0]
        let currentController = currentOperation.notificationController.topViewController
        guard currentController != DPNotificationViewController.findTopViewController() ||
              currentController != DPNotificationViewController.findTopViewControllerInNavigationController() else { return }
        
        currentOperation.notificationController.closeNotification(animated: false)
    }
    
    public func cancelAll() {
        let ops = operationQueue.operations.filter { $0 is DPNotificationViewOperation  }
        for op in ops {
            op.cancel()
        }
    }
}
