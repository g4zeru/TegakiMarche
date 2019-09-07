//
//  ItemCompactListCell.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/15.
//

import UIKit

class ItemCompactListCell: UICollectionViewCell {
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    class var cellHeightRatio: CGFloat {
        return 350 / 218
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowOpacity = 0.5
        self.overlayView.layer.masksToBounds = true
        self.overlayView.layer.cornerRadius = 10
    }

    func update(title: String, price: Int, image: UIImage) {
        self.thumbnailImageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = "¥" + price.separatedByThreeDigitsWithComma
    }
}
