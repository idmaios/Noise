//
//  NoiseOperation.swift
//  Noise
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation

class NoiseOperation: Operation {
    
    let notificationController: NoiseController

    override var isAsynchronous: Bool {
        return false
    }
    
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    fileprivate var _executing = false
    
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    fileprivate var _finished = false
    
    
    init(notificationController: NoiseController) {
        self.notificationController = notificationController
        
        super.init()
        
        qualityOfService = .userInitiated
    }
    
    
    override func start() {
        guard isCancelled != true else { isFinished = true; return }
        
        isExecuting = true
        main()
    }
    
    override func main() {
        notificationController.showNotification()
    }
    
    func completeOperation() {
        isExecuting = false
        isFinished  = true
    }
    
    override func cancel() {
        guard isExecuting == false else { return }
        
        super.cancel()
    }
}
