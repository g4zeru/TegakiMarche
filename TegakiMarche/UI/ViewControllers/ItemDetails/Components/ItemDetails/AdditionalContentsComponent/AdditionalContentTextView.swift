//
//  AdditionalContentTextView.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/15.
//

import SnapKit
import UIKit

class AdditionalContentTextView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.hiraginoW3(size: 14)
        view.textColor = UIColor.darkGray
        view.numberOfLines = 0
        return view
    }()

    private var attributes: [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle: NSMutableParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = .left
            style.lineSpacing = 8
            return style
        }()
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        attributes.updateValue(UIFont.hiraginoW3(size: 13), forKey: .font)
        attributes.updateValue(UIColor.darkGray, forKey: .foregroundColor)
        attributes.updateValue(UIColor.clear, forKey: .backgroundColor)
        return attributes
    }

    init(text: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(self.label)
        self.label.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview()
        }
        self.label.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
