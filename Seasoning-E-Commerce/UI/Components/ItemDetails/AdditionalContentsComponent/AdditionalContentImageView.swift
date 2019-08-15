//
//  AdditionalContentImageView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit
import SnapKit

class AdditionalContentImageView: UIView {
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    init(image: URL, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(5)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(-5)
            maker.width.equalTo(self.imageView.snp.height).multipliedBy(376/232)
        }
        self.imageView.setImage(url: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
