//
//  ViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/04.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 35
        flowlayout.minimumInteritemSpacing = 30
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.backgroundColor = UIColor.clear
        view.register(UINib(nibName: "ListHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "listheader")
        view.register(UINib(nibName: "RecommendedListCell", bundle: nil), forCellWithReuseIdentifier: "recommendedlistcell")
        view.register(UINib(nibName: "HotRankingCell", bundle: nil), forCellWithReuseIdentifier: "hotrankingcell")
        return view
    }()
    
    override func loadView() {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.white
        self.view = backgroundView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthMargin: CGFloat = 20
        let cellMargin: CGFloat = 30
        let width = (collectionView.frame.width - widthMargin * 2 - cellMargin) / 2
        return  CGSize(width: width, height: width * HotRankingCell.cellHeightRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.contentSize.width, height: 85)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotrankingcell", for: indexPath) as! HotRankingCell
        //cell.update(title: "自家農園産自然栽培原料•低温圧搾生搾り黒ごま油110g", subtitle: "黒ごまの旨味を凝縮した至高の一品", price: 1300)
        cell.update(title: "B&B Canada No.1 メープルシロップ　ミディアム", price: 1120)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "listheader", for: indexPath) as! ListHeaderView
            view.update(title: "Today’s\nRecommendations!")
            return view
        } else {
            return UICollectionReusableView()
        }
    }
}

