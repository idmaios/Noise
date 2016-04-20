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
    }
    
    public func cancelAll() {
        let ops = operationQueue.operations.filter { $0 is DPNotificationViewOperation  }
        for op in ops {
            op.cancel()
        }
    }
}
