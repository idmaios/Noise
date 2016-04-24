//
//  DPDefaultNotififcationView.swift
//  DPNotificationController
//
//  Created by Nick on 20/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

protocol DPNotficationViewCompatible {
    associatedtype View: UIView = Self
    
//    init(frame: CGRect, message: String, icon: UIImage?, buttonAction: (() -> ())?)
//    var height: CGFloat { get }
//    var message: String { set get }
//    var icon: UIImage { set get }
//    var action: () -> () { set get }
}

class DPXibLoadView: UIView {
    
    let xibName: String?
    @IBOutlet weak var view : UIView!
    
    init(frame: CGRect, xibName: String? = nil) {
        self.xibName = xibName
        
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.xibName = nil
        
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        view = loadViewFromXib()
        
        let correctSize = CGSize(width: frame.width, height: view.frame.height)
        frame = CGRect(origin: frame.origin, size: correctSize)
        view.frame = CGRect(origin: view.frame.origin, size: correctSize)
        
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        backgroundColor = .clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib    = UINib(nibName: xibName ?? String(self.dynamicType), bundle: bundle)
        let view   = nib.instantiateWithOwner(self, options: nil).first as! UIView
        return view
    }
}

class DPDefaultNotififcationView: DPXibLoadView, DPNotficationViewCompatible {
    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var iconConstraint: NSLayoutConstraint!
    
    
    required init(maxSize: CGSize, message: String, icon: UIImage? = nil, xibName: String? = nil, buttonAction: (() -> ())? = nil) {
        super.init(frame: CGRect(origin: CGPointZero, size: maxSize), xibName: xibName)
        
        iconView.image    = icon
        messageLabel.text = message
        
        if icon == nil {
            iconConstraint.priority = UILayoutPriorityDefaultLow
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = self.superview else { return }
        
        messageLabel.preferredMaxLayoutWidth = superview.frame.width - messageLabel.frame.origin.x - self.view.layoutMargins.right
    }
    
//    override func intrinsicContentSize() -> CGSize {
//        return CGSize(width: frame.width, height: -1)
//    }
}
