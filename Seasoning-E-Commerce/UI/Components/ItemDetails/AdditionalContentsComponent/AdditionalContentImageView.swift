//
//  AdditionalContentImageView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import SnapKit
import UIKit

class AdditionalContentImageView: UIView {
    internal let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()

    init(image: URL, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview()
            maker.width.equalTo(self.imageView.snp.height).multipliedBy(3.5 / 2)
        }
        self.imageView.setImage(url: image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
