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
    case Error
    case Warning
    case Default
    case Success
}

@objc
public class Noise: NSObject {
    
    public static let DefaultNotificationDuration = 2.0
    
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
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, type: NoiseType) {
        Noise.generalShowWith(message: message, title: title, icon: icon, type: type)
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
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, type: NoiseType, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, duration: duration, type: type, action: callBack)
    }
    
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, blured: Bool, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, duration: duration, blured: blured, action: callBack)
    }
    
    public class func showNotificationWith(title title: String?, message: String, icon: UIImage?, viewController: UIViewController?, duration: Double, backgroundColor: UIColor, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: viewController, duration: duration, backgroundColor: backgroundColor, action: callBack)
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
                                      duration: Double? = DefaultNotificationDuration,
                                          icon: UIImage? = nil,
                                        blured: Bool = false,
                               backgroundColor: UIColor? = nil,
               inViewController viewController: UIViewController? = nil,
                                          type: NoiseType = .Default,
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
                    case .Error:   view.backgroundColor = UIColor(red: 204 / 255, green: 102 / 255, blue: 103 / 255, alpha: 1)
                    case .Warning: view.backgroundColor = UIColor(red: 239 / 255, green: 197 / 255, blue: 116 / 255, alpha: 1)
                    case .Default: view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
                    case .Success: view.backgroundColor = UIColor(red: 144 / 255, green: 209 / 255, blue: 119 / 255, alpha: 1)
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
    public func showNoise(title title: String?, message: String, icon: UIImage?, type: NoiseType) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, type: type)
    }
    
    @objc
    public func showNoise(title title: String?, message: String, icon: UIImage?, duration: Double, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: duration, action: callBack)
    }
    
    @objc
    public func showNoise(title title: String?, message: String, icon: UIImage?, duration: Double, type: NoiseType, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: duration, type: type, action: callBack)
    }
    
    public func showNoise(title title: String?, message: String, icon: UIImage?, duration: Double, backgroundColor: UIColor?, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: duration, backgroundColor: backgroundColor, action: callBack)
    }
    
    public func showNoise(title title: String?, message: String, icon: UIImage?, duration: Double, blured: Bool, callBack: (() -> ())?) {
        Noise.generalShowWith(message: message, title: title, icon: icon, inViewController: self, duration: duration, blured: blured, action: callBack)
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