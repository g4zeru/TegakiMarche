// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:12.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate
import InstantiateStandard

class FullScreenContentCell: HomeContentCell, Reusable, NibType, NibInstantiatable {
    typealias Dependency = Firebase.Item
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        contentImageView.clipsToBounds = true
        contentImageView.layer.cornerRadius = self.cellCornerRadius

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
    }
    
    func inject(_ dependency: Firebase.Item) {
        contentImageView.setImage(url: dependency.thumbnailImagePath!)
        titleLabel.text = dependency.title
        subTitleLabel.text = dependency.subTitle
    }
}
