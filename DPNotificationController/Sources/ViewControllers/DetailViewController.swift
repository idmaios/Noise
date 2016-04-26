//
//  DetailViewController.swift
//  DPNotificationController
//
//  Created by Nick on 25/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    @IBAction func presentInViewController(sender: UIButton) {
        DPNotification.showNotificationWith(message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", title: "Some title", icon: UIImage(named: "Check"))
    }
    
    @IBAction func presentInViewControllerWithNavBarHidding(sender: UIButton) {
        DPNotification.showNotificationWith(message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", title: "Some title", icon: UIImage(named: "Check"))
    }
    
    @IBAction func presentInNavigationController(sender: UIButton) {
        DPNotification.showNotificationWith(message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", title: "Some title", icon: UIImage(named: "Check"))
    }
    
    @IBAction func dismissSelf(sender: UIBarButtonItem) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
