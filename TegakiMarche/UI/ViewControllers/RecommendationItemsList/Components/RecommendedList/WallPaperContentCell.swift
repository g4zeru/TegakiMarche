// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:13.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate
import InstantiateStandard

class WallPaperContentCell: HomeContentCell, Reusable, NibType, NibInstantiatable {
    typealias Dependency = Firebase.Item
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var deviceLabel: UILabel!
    @IBOutlet private weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.masksToBounds = true
        contentImageView.layer.cornerRadius = self.cellCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        deviceLabel.text = nil
        contentImageView.image = nil
    }
    
    func inject(_ dependency: Firebase.Item) {
        titleLabel.text = dependency.title
        deviceLabel.text = dependency.subTitle
        contentImageView.setImage(url: dependency.thumbnailImagePath!)
    }
}
