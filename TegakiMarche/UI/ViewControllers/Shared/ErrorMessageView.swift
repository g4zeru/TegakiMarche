//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 4:13.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import UIKit

class ErrorMessageView: UIView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        self.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
