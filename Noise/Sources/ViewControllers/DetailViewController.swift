//
//  DetailViewController.swift
//  Noise
//
//  Created by Nick on 25/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBAction func dismissSelf(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func presentInViewController(_ sender: UIButton) {
        showNotification(inViewController: self)
    }
    
    @IBAction func presentInViewControllerWithNavBarHidding(_ sender: UIButton) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { [weak self] in
            self?.showNotification(inViewController: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { [weak self] in
                self?.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    @IBAction func presentInNavigationController(_ sender: UIButton) {
        showNotification(inViewController: navigationController)
    }
    
    @IBAction func presentSharedNotification(_ sender: UIButton) {
        showNotification(inViewController: nil)
    }
    
    func showNotification(inViewController controller: UIViewController?) {
        Noise.showNotificationWith(title: "Some title", message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj", icon: UIImage(named: "Check"), viewController: controller, duration: Noise.DefaultNotificationDuration, blured: true, callBack: nil)
    }
}
