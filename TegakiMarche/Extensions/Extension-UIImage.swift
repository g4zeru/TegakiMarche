//
//  Extension-UIImage.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/14.
//

import UIKit

extension UIImage {
    class var heartSquareIcon: UIImage {
        return UIImage(named: "heart-square-icon")!.withRenderingMode(.alwaysTemplate)
    }
    var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
}
