//
//  HotRankingCell.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class HotRankingCell: UICollectionViewCell {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        overlayView.layer.shadowOpacity = 0.8
        overlayView.layer.shadowRadius = 6
        overlayView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    func update(title: String, price: Int) {
        updateTitleLabel(text: title)
        self.priceLabel.text = "¥\(price)"
    }

    private func updateTitleLabel(text: String) {
        let titleAttributes: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle.generate(alignment: .left, lineSpacing: 5)
            return NSAttributedString.generate(foregroundColor: UIColor.customBlack,
                                               backgroundColor: UIColor.clear,
                                               font: UIFont.hiraginoW6(size: 11),
                                               paragraphStyle: style)
        }()
        self.titleLabel.attributedText = NSAttributedString(string: text, attributes: titleAttributes)
    }
}
