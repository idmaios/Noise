//
//  Noise.swift
//  Noise
//
//  Created by Nick on 22/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

@objc
public class Noise: NSObject {
    
    @objc
    public class func showNotificationWith(message message: String) {
        Noise.generalShowWith(message: message)
    }
    
    @objc
    public class func showNotificationWith(title title: String, message: String) {
        Noise.generalShowWith(message: message, title: title)
    }
    
    @objc
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?) {
        Noise.generalShowWith(message: message, title: title, icon: icon)
    }
    
    @objc
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController)
    }
    
    @objc
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, duration: duration, action: callBack)
    }
    
    @objc
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?, untilUserClose: Bool, callBack: (() -> ())?) {
        if untilUserClose {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, duration: nil, action: callBack)
        } else {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, action: callBack)
        }
    }
    
    class func generalShowWith(message message: String,
                                         title: String? = nil,
                                      duration: Double? = NoiseController.NoiseDefaultDuration,
                                          icon: UIImage? = nil,
               inViewController viewController: UIViewController? = nil,
                                        action: (() -> ())? = nil) {
    
        let controller = NoiseController() { (maxSize, topOffset) in
            if let action = action {
                return NoiseDefaultBluredView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon, callBack: action)
            } else {
                return NoiseDefaultBluredView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon)
            }
        }
        
        controller.show(inFixedViewController: viewController, duration: duration)
    }
}

public extension UIViewController {
    
    @objc
    public func showNoise(message: String) {
        Noise.generalShowWith(message: message, inViewController: self)
    }
    
    @objc
    public func showNoise(title title: String, message: String) {
        Noise.generalShowWith(message: message, title: title, inViewController: self)
    }
    
    @objc
    public func showNoise(title title: String?, message: String, icon: UIImage) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self)
    }
    
    @objc
    public func showNoise(title title: String?, message: String, icon: UIImage?, duration: Double, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: duration, action: callBack)
    }
    
    @objc
    public func showNoise(title title: String?, message: String, icon: UIImage?, untilUserClose: Bool, callBack: (() -> ())?) {
        if untilUserClose {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: nil, action: callBack)
        } else {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, action: callBack)
        }
    }
}