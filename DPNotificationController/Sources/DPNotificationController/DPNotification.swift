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
    public class func showNotificationWith(message message: String, title: String? = nil, icon: UIImage? = nil, action: (() -> ())? = nil) {
        guard let controller = DPNotificationViewController() else { return }
        
        controller.view = DPDefaultNotififcationView(maxSize: controller.maxSize, message: message, title: title, icon: icon, buttonAction: action)
        controller.show()
    }
}