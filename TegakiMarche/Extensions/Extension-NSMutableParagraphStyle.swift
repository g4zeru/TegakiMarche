//
//  Extension-NSMutableParagraphStyle.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

extension NSMutableParagraphStyle {
    class func generate(alignment: NSTextAlignment = .center, lineSpacing: CGFloat = .zero) -> NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineSpacing = lineSpacing
        return style
    }
}
