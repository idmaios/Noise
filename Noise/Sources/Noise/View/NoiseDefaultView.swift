//
//  NoiseDefaultView.swift
//  Noise
//
//  Created by Nick on 20/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit

class NoiseXibLoadView: UIView {
    
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
    
    fileprivate func xibSetup() {
        view = loadViewFromXib()
        
        let correctSize = CGSize(width: frame.width, height: view.frame.height)
        frame = CGRect(origin: frame.origin, size: correctSize)
        view.frame = CGRect(origin: view.frame.origin, size: correctSize)
        
        view.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        backgroundColor = .clear
        
        addSubview(view)
    }
    
    fileprivate func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib    = UINib(nibName: xibName ?? String(describing: type(of: self)), bundle: bundle)
        let view   = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

class NoiseDefaultView: NoiseXibLoadView {
    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    fileprivate let DPDefaultNotififcationViewBottomOffset: CGFloat = 15
    fileprivate let DPDefaultNotififcationViewMaxHeight: CGFloat = 999
    fileprivate var DPDefaultNotififcationViewMinHeight: CGFloat = 44
    
    required init(maxSize: CGSize, topOffset: CGFloat, message: String, title: String? = nil, icon: UIImage? = nil) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: maxSize))
        
        iconView.image    = icon
        messageLabel.text = message
        titleLabel.text   = title
        
        DPDefaultNotififcationViewMinHeight = topOffset == 0 ? 50 : 44
        
        var newMessageFrame = messageLabel.frame
        if title == nil {
            newMessageFrame.origin.y    = messageLabel.frame.origin.y - titleLabel.frame.height
            newMessageFrame.size.height = messageLabel.frame.height + titleLabel.frame.height
        }
        if icon == nil {
            var newTitleFrame          = titleLabel.frame
            newTitleFrame.origin.x     = view.layoutMargins.left
            newTitleFrame.size.width   = maxSize.width - view.layoutMargins.left - view.layoutMargins.right
            newMessageFrame.origin.x   = newTitleFrame.origin.x
            newMessageFrame.size.width = newTitleFrame.size.width
            titleLabel.frame           = newTitleFrame
        }
        messageLabel.frame = newMessageFrame
        
        var newContentViewFrame         = contentView.frame
        newContentViewFrame.origin.y    = topOffset
        newContentViewFrame.size.height -= topOffset
        contentView.frame               = newContentViewFrame
        
        updateFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateFrames()
    }
    
    fileprivate func updateFrames() {
        view.frame = bounds
        
        var newContentViewFrame         = contentView.frame
        newContentViewFrame.size.width  = min(672, view.frame.width)
        newContentViewFrame.origin.x    = (view.frame.width - newContentViewFrame.width) / 2
        contentView.frame               = newContentViewFrame
        
        let labelMaxSize       = CGSize(width: messageLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let messageLabelHeight = ceil(messageLabel.sizeThatFits(labelMaxSize).height)
        let totalHeight        = messageLabelHeight + (titleLabel.text == nil ? 0 : titleLabel.frame.size.height)
        
        if totalHeight < DPDefaultNotififcationViewMinHeight {
            let diff = (DPDefaultNotififcationViewMinHeight - totalHeight) / 2
            var newFrame      = titleLabel.frame
            newFrame.origin.y = diff
            titleLabel.frame  = newFrame

            newFrame             = messageLabel.frame
            newFrame.origin.y    = titleLabel.text == nil ? diff : titleLabel.frame.maxY
            newFrame.size.width  = bounds.width  - newFrame.origin.x - view.layoutMargins.right
            newFrame.size.height = messageLabelHeight
            messageLabel.frame   = newFrame
        }
        
        var newFrame = frame
        newFrame.size.height = min(max(DPDefaultNotififcationViewMinHeight, totalHeight + DPDefaultNotififcationViewBottomOffset), DPDefaultNotififcationViewMaxHeight) + contentView.frame.origin.y
        frame = newFrame
        
        view.frame = bounds
    }
}

class NoiseDefaultBluredView: NoiseDefaultView {
}
