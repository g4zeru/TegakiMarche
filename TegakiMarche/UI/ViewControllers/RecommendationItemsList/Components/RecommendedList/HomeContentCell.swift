// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 23:01.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit

class HomeContentCell: UICollectionViewCell {
    let overlayView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.4
        view.backgroundColor = UIColor.white
        return view
    }()
    var cellCornerRadius: CGFloat = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.masksToBounds = false
        self.insertSubview(overlayView, at: 0)
        overlayView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.overlayView.layer.cornerRadius = cellCornerRadius
    }
}
