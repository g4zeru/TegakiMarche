//
//  ExtensionNSAttribute.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

extension NSAttributedString {
    class var defaultTitleAttribute: [NSAttributedString.Key: Any] {
        var keys = [NSAttributedString.Key: Any]()
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineSpacing = 5
        keys.updateValue(UIFont.hiraginoW6(size: 15), forKey: .font)
        keys.updateValue(UIColor.customBlack, forKey: .foregroundColor)
        keys.updateValue(style, forKey: .paragraphStyle)
        return keys
    }
    
    class func generate(foregroundColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.white, font: UIFont, paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle(), anyKeys: [NSAttributedString.Key: Any] = [:])->[NSAttributedString.Key: Any] {
        var keys = [NSAttributedString.Key: Any]()
        anyKeys.forEach { (key, value) in
            keys.updateValue(value, forKey: key)
        }
        keys.updateValue(font, forKey: .font)
        keys.updateValue(foregroundColor, forKey: .foregroundColor)
        keys.updateValue(backgroundColor, forKey: .backgroundColor)
        keys.updateValue(paragraphStyle, forKey: .paragraphStyle)
        return keys
    }
}
