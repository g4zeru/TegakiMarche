//
//  ItemListCell.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit

class ItemListCell: UICollectionViewCell {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonOverlayView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    class var cellHeightRatio: CGFloat {
        return 312/177
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.overlayView.layer.masksToBounds = true
        self.overlayView.layer.cornerRadius = 10
        self.buttonOverlayView.layer.cornerRadius = 10
        self.buttonOverlayView.layer.shadowOpacity = 0.5
        self.buttonOverlayView.layer.shadowRadius = 3
        self.buttonOverlayView.layer.shadowOffset = CGSize(width: 2, height: 3)
    }
    
    func update(title: String, buttonTitle: String, image: UIImage) {
        self.thumbnailImageView.image = image
        self.titleLabel.text = title
        self.button.setTitle(buttonTitle, for: .normal)
    }
}
