//
//  RecommendedListCell.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/14.
//

import UIKit

class RecommendedListCell: UICollectionViewCell {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var optionsView: UIView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var purchaseButton: UIButton!
    @IBOutlet private weak var purchaseButtonOverlayView: UIView!
    
    class var cellHeightRatio: CGFloat {
        return 530/363
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        overlayView.layer.cornerRadius = 10
        overlayView.layer.masksToBounds = true
        optionsView.layer.cornerRadius = 15
        purchaseButtonOverlayView.layer.cornerRadius = 10
        purchaseButtonOverlayView.layer.shadowOffset = CGSize(width: 2, height: 3)
        purchaseButtonOverlayView.layer.shadowRadius = 3
        purchaseButtonOverlayView.layer.shadowOpacity = 0.5
    }
    
    func update(title: String, subtitle: String, price: Int) {
        updateTitleText(text: title)
        updateSubtitleText(text: subtitle)
        self.purchaseButton.setTitle("¥\(price)", for: .normal)
    }
    
    private func updateTitleText(text: String) {
        let titleAttributes: [NSAttributedString.Key: Any] = {
            let style = NSMutableParagraphStyle.generate(alignment: .left, lineSpacing: 5)
            return NSAttributedString.generate(foregroundColor: UIColor.customBlack,
                                               backgroundColor: UIColor.clear,
                                               font: UIFont.hiraginoW6(size: 15),
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
