//
//  DPNotification.swift
//  DPNotificationController
//
//  Created by Nick on 22/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

public class DPNotification {
    public class func showNotificationWith(message message: String, title: String? = nil, icon: UIImage? = nil, inViewController viewController: UIViewController? = nil, action: (() -> ())? = nil) {
        let controller = DPNotificationViewController() {
            DPDefaultNotififcationView(maxSize: $0, message: message, title: title, icon: icon, buttonAction: action)
        }
        
        controller.show(inFixedViewController: viewController)
    }
}