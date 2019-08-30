//
//  ShopItemsSectionView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/18.
//

import SnapKit
import UIKit

class ShopItemsSectionView: UIView {
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.font = .hiraginoW6(size: 17)
        view.textColor = .darkGray
        view.textAlignment = .left
        return view
    }()
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.connectViewAnchor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func connectViewAnchor() {
        self.addSubview(self.headerLabel)
        self.addSubview(self.collectionView)
        self.headerLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(30)
        }
        self.collectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
    }
}
