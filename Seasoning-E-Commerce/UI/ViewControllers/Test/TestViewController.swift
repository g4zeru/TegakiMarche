//
//  TestViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import SnapKit
import UIKit

class TestViewController: UIViewController {
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.clear
        view.register(UINib(nibName: "ItemListCell", bundle: nil), forCellWithReuseIdentifier: "itemlist")
        view.register(UINib(nibName: "ItemCompactListCell", bundle: nil), forCellWithReuseIdentifier: "itemcompactlist")
        view.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        view.accessibilityIdentifier = "TestCollectionView"
        return view
    }()

    override func loadView() {
        let backview = UIView(frame: UIScreen.main.bounds)
        backview.backgroundColor = UIColor.white
        self.view = backview
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemcompactlist", for: indexPath) as? ItemCompactListCell else {
            fatalError()
        }
        //cell.update(title: "ヨシダ グルメのたれ オリジナル 645g", buttonTitle: "レビュー", image: UIImage(named: "Item6")!)
        cell.update(title: "ヨシダ グルメのたれ オリジナル 645g", price: 1_000, image: UIImage(named: "Item6") ?? UIImage())
        return cell
    }
}

extension TestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let widthMargin: CGFloat = 20
        let width = (collectionView.frame.width - widthMargin * 2 - margin) / 2
        return CGSize(width: width, height: width * ItemCompactListCell.cellHeightRatio)
    }
}
