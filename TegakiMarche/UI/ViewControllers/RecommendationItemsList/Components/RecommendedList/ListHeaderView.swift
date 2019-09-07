//
//  ListHeaderView.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class ListHeaderView: UICollectionReusableView {
    @IBOutlet private weak var label: UILabel!

    func update(title: String) {
        self.label.text = title
    }
}
