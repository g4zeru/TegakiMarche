//
//  RecommendedListCell.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class RecommendedListCell: UICollectionViewCell {
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var optionsView: UIView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var purchaseButton: UIButton!
    @IBOutlet private weak var purchaseButtonOverlayView: UIView!
    
    class var cellHeightRatio: CGFloat {
        return 26/18
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.2
        self.overlayView.layer.cornerRadius = 10
        self.overlayView.layer.masksToBounds = true
        self.optionsView.layer.cornerRadius = self.optionsView.frame.height/2
        self.purchaseButtonOverlayView.layer.cornerRadius = self.purchaseButtonOverlayView.frame.height/2
    }
    
    func update(item: Item) {
        self.thumbnailImageView.setImage(url: item.image)
        self.updateTitleText(text: item.title)
        self.updateSubtitleText(text: item.description)
        self.rateLabel.text = String(item.rate)
        self.purchaseButton.setTitle("¥\(item.price.separatedByThreeDigitsWithComma)", for: .normal)
    }
    
    private func updateTitleText(text: String) {
        let titleAttributes: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle.generate(alignment: .left, lineSpacing: 5)
            return NSAttributedString.generate(foregroundColor: UIColor.customBlack,
                                               backgroundColor: UIColor.clear,
                                               font: UIFont.hiraginoW6(size: 16),
                                               paragraphStyle: style)
        }()
        
        self.titleLabel.attributedText = NSAttributedString(string: text, attributes: titleAttributes)
    }
    
    private func updateSubtitleText(text: String) {
        let subtitleAttributes: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle.generate(alignment: .left)
            let attributes = NSAttributedString.generate(foregroundColor: UIColor.customGray,
                                                         backgroundColor: UIColor.clear,
                                                         font: UIFont.hiraginoW6(size: 14),
                                                         paragraphStyle: style)
            return attributes
        }()
        
        self.subtitleLabel.attributedText = NSAttributedString(string: text, attributes: subtitleAttributes)
    }
}
