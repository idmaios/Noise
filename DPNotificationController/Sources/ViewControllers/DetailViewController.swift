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
    
    @IBAction func dismissSelf(sender: UIBarButtonItem) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func presentInViewController(sender: UIButton) {
        showNotification(inViewController: self)
    }
    
    @IBAction func presentInViewControllerWithNavBarHidding(sender: UIButton) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        showNotification(inViewController: self)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func presentInNavigationController(sender: UIButton) {
        showNotification(inViewController: navigationController)
    }
    
    func showNotification(inViewController controller: UIViewController?) {
        DPNotification.showNotificationWith(message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", title: "Some title", icon: UIImage(named: "Check"), inViewController: controller)
    }
}
