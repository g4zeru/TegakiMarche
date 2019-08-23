// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 4:18.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import SnapKit

class LoadingOvelayView: UIView {

    let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .init(displayP3Red: 75/255, green: 75/255, blue: 75/255, alpha: 0.2)
        self.addSubview(indicator)
        indicator.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.width.equalTo(50)
            maker.height.equalTo(indicator.snp.width)
        }
    }
    
    func start() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func stop() {
        indicator.isHidden = true
        indicator.stopAnimating()
    }

}
