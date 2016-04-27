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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
            self?.showNotification(inViewController: self)
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [weak self] in
                self?.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    @IBAction func presentInNavigationController(sender: UIButton) {
        showNotification(inViewController: navigationController)
    }
    
    @IBAction func presentSharedNotification(sender: UIButton) {
        showNotification(inViewController: nil)
    }
    
    func showNotification(inViewController controller: UIViewController?) {
        DPNotification.showNotificationWith(title: "Some title", message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", icon: UIImage(named: "Check"), viewController: controller)
    }
}
