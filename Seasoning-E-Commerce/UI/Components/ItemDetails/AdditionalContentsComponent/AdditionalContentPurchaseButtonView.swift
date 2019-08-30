//
//  AdditionalContentPurchaseButtonView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import SnapKit
import UIKit

class AdditionalContentPurchaseButtonView: UIView {
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 2, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        return view
    }()
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("購入する", for: .normal)
        button.titleLabel?.font = UIFont.hiraginoW6(size: 17)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        return button
    }()

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.overlayView)
        self.overlayView.addSubview(self.button)
        self.overlayView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.width.equalTo(self.overlayView.snp.height).multipliedBy(86 / 13)
            maker.top.equalToSuperview().offset(20)
            maker.leading.equalToSuperview().offset(35)
        }

        self.button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
