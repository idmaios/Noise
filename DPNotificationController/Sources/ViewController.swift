//
//  ViewController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func presentNotificationController(sender: UIButton) {
        flag = 1
        for _ in 1...7 {
            DPNotificationController(message: "tmp").show()
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(8 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            DPNotificationManager.manager.cancelAll()
        }
    }
}

