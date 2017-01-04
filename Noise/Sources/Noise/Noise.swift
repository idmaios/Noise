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
public enum NoiseType: Int {
    case error
    case warning
    case `default`
    case success
}

@objc
open class Noise: NSObject {
    
    open static let DefaultNotificationDuration = 2.0
    
    @objc
    open class func showNotificationWith(message: String) {
        Noise.generalShowWith(message: message)
    }
    
    @objc
    open class func showNotificationWith(title: String, message: String) {
        Noise.generalShowWith(message: message, title: title)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?) {
        Noise.generalShowWith(message: message, title: title, icon: icon)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, type: NoiseType) {
        Noise.generalShowWith(message: message, title: title, icon: icon, type: type)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, inViewController: viewController, action: callBack)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, type: NoiseType, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, inViewController: viewController, type: type, action: callBack)
    }
    
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, blured: Bool, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, blured: blured, inViewController: viewController, action: callBack)
    }
    
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, backgroundColor: UIColor, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, backgroundColor: backgroundColor, inViewController: viewController, action: callBack)
    }
    
    @objc
    open class func showNotificationWith(title: String?, message: String, icon: UIImage?, viewController: UIViewController?, untilUserClose: Bool, callBack: (() -> ())?) {
        if untilUserClose {
            Noise.generalShowWith(message: message, title: title, duration: nil, icon: icon, inViewController: viewController, action: callBack)
        } else {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, action: callBack)
        }
    }
    
    class func generalShowWith(message: String,
                                         title: String? = nil,
                                      duration: Double? = DefaultNotificationDuration,
                                          icon: UIImage? = nil,
                                        blured: Bool = false,
                               backgroundColor: UIColor? = nil,
               inViewController viewController: UIViewController? = nil,
                                          type: NoiseType = .default,
                                        action: (() -> ())? = nil) {
    
        let controller = NoiseController() { (maxSize, topOffset) in
            var view: NoiseDefaultView!
            switch (blured, action) {
                case (true, nil):  view = NoiseDefaultBluredView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon)
                case (false, nil): view = NoiseDefaultView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon)
                case (true, _):    view = NoiseDefaultBluredView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon, callBack: action!)
                case (false, _):   view = NoiseDefaultView(maxSize: maxSize, topOffset: topOffset, message: message, title: title, icon: icon, callBack: action!)
            }
            
            if let backgroundColor = backgroundColor {
                view.backgroundColor = backgroundColor
            } else {
                if !blured {
                    switch type {
                    case .error:   view.backgroundColor = UIColor(red:0.98, green:0.27, blue:0.35, alpha:1.00)
                    case .warning: view.backgroundColor = UIColor(red:1.00, green:0.47, blue:0.31, alpha:1.00)
                    case .default: view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
                    case .success: view.backgroundColor = UIColor(red:0.56, green:0.78, blue:0.25, alpha:1.00)
                    }
                }
            }
            return view
        }
        
        controller.show(inFixedViewController: viewController, duration: duration)
    }
}

public extension UIViewController {
    
    @objc
    public func showNoise(_ message: String) {
        Noise.generalShowWith(message: message, inViewController: self)
    }
    
    @objc
    public func showNoise(title: String, message: String) {
        Noise.generalShowWith(message: message, title: title, inViewController: self)
    }
    
    @objc
    public func showNoise(title: String?, message: String, icon: UIImage) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self)
    }
    
    @objc
    public func showNoise(title: String?, message: String, icon: UIImage?, type: NoiseType) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, type: type)
    }
    
    @objc
    public func showNoise(title: String?, message: String, icon: UIImage?, duration: Double, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, inViewController: self, action: callBack)
    }
    
    @objc
    public func showNoise(title: String?, message: String, icon: UIImage?, duration: Double, type: NoiseType, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, inViewController: self, type: type, action: callBack)
    }
    
    public func showNoise(title: String?, message: String, icon: UIImage?, duration: Double, backgroundColor: UIColor?, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, backgroundColor: backgroundColor, inViewController: self, action: callBack)
    }
    
    public func showNoise(title: String?, message: String, icon: UIImage?, duration: Double, blured: Bool, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, duration: duration, icon: icon, blured: blured, inViewController: self, action: callBack)
    }
    
    @objc
    public func showNoise(title: String?, message: String, icon: UIImage?, untilUserClose: Bool, callBack: (() -> ())?) {
        if untilUserClose {
            Noise.generalShowWith(message: message, title: title, duration: nil, icon: icon, inViewController: self, action: callBack)
        } else {
            Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, action: callBack)
        }
    }
}
