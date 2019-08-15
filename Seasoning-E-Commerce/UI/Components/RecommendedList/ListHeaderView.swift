//
//  ListHeaderView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class ListHeaderView: UICollectionReusableView {

    @IBOutlet weak var label: UILabel!
    
    func update(title: String) {
        self.label.text = title
    }
}
