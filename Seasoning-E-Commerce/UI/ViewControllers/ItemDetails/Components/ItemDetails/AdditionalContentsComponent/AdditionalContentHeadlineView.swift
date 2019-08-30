//
//  AdditionalContentHeadlineView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/16.
//

import SnapKit
import UIKit

class AdditionalContentHeadlineView: UIView {
    let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.hiraginoW6(size: 15)
        view.numberOfLines = 1
        view.textColor = UIColor.darkGray
        return view
    }()

    init(text: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(self.label)
        self.label.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
            maker.bottom.equalToSuperview()
            maker.height.equalTo(16)
        }
        self.label.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
