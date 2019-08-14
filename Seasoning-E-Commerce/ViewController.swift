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
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.backgroundColor = UIColor.clear
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
        let widthMergin: CGFloat = 20
        let width = collectionView.frame.width - widthMergin * 2
        return  CGSize(width: width, height: width * RecommendedListCell.cellHeightRatio)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedlistcell", for: indexPath) as! RecommendedListCell
        cell.setTitles(title: "自家農園産自然栽培原料•低温圧搾生搾り黒ごま油110g", subtitle: "黒ごまの旨味を凝縮した至高の一品", price: 1300)
        return cell
    }
}

