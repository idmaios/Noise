//
//  DPNOtificationViewOperation.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation

class DPNotificationViewOperation: NSOperation {
    
    let notificationController: DPNotificationView

    override var asynchronous: Bool {
        return false
    }
    
    override var executing: Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    private var _executing = false
    
    override var finished: Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    private var _finished = false
    
    
    init(notificationController: DPNotificationView) {
        self.notificationController = notificationController
        
        super.init()
        
        qualityOfService = .UserInitiated
    }
    
    
    override func start() {
        guard cancelled != true else { finished = true; return }
        
        executing = true
        main()
    }
    
    override func main() {
        notificationController.showNotification()
    }
    
    func completeOperation() {
        executing = false
        finished  = true
    }
    
    override func cancel() {
        guard executing == false else { return }
        
        super.cancel()
    }
}
