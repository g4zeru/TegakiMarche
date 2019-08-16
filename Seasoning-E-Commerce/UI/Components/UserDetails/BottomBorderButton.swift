//
//  BottomBorderButton.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/16.
//

import UIKit

class BottomBorderButton: UIButton {
    private let bottomBorder: CALayer
    var borderHeight: CGFloat {
        get {
            return bottomBorder.frame.height
        }
        
        set {
            updateFrame(height: newValue)
        }
    }
    
    var borderColor: CGColor {
        get {
            return bottomBorder.backgroundColor ?? UIColor.clear.cgColor
        }
        set {
            bottomBorder.backgroundColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        bottomBorder = {
            let layer = CALayer()
            return layer
        }()
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        bottomBorder = {
            let layer = CALayer()
            return layer
        }()
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateFrame(height: self.borderHeight)
    }
    
    private func setup() {
        self.layer.addSublayer(bottomBorder)
        self.addObserver(self, forKeyPath: "frame", options: [.old, .new], context: nil)
    }
    
    private func updateFrame(height: CGFloat) {
        self.bottomBorder.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: height)
    }
}
