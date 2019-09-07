//
//  Extension-Int.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/15.
//

import Foundation

extension Int {
    var separatedByThreeDigitsWithComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
