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
        DPNotificationController(message: "tmp").show()
    }
}

