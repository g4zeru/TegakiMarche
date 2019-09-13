// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 0:16.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate

class MusicContentCollectionViewCell: UICollectionViewCell, NibType, Reusable {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        overlayView.layer.cornerRadius = 5
        overlayView.layer.shadowOffset = CGSize(width: 2, height: 2)
        overlayView.layer.shadowRadius = 3
        overlayView.layer.shadowOpacity = 0.2
        contentImageView.layer.masksToBounds = true
        contentImageView.layer.cornerRadius = 5
        contentImageView.contentMode = .scaleAspectFill
    }
}
