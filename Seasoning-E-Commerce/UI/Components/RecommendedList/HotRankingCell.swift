//
//  HotRankingCell.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class HotRankingCell: UICollectionViewCell {
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    class var cellHeightRatio: CGFloat {
        return 222/166
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        overlayView.layer.masksToBounds = true
        overlayView.layer.cornerRadius = 10
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
