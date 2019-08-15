//
//  AdditionalContentHeaderView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit
import SnapKit

class AdditionalContentHeaderView: UIView {
    let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.hiraginoW6(size: 14)
        view.numberOfLines = 1
        view.textColor = UIColor.darkGray
        return view
    }()
    init(text: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(self.label)
        self.label.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(20)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(-5)
            maker.height.equalTo(15)
        }
        self.label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
