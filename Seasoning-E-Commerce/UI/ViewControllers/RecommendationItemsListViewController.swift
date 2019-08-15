//
//  RecommendationItemsListViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit
import SnapKit

class RecommendationItemsListViewController: UIViewController {
    var recommendationItems: [Item] = []
    var hotrankingItems: [Item] = []
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.clear
        view.register(UINib(nibName: "RecommendedListCell", bundle: nil), forCellWithReuseIdentifier: "reccommendedlist")
        view.register(UINib(nibName: "HotRankingCell", bundle: nil), forCellWithReuseIdentifier: "hotrankingcell")
        view.register(UINib(nibName: "ListHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "listheader")
        return view
    }()
    
    override func loadView() {
        let backView = UIView(frame: UIScreen.main.bounds)
        backView.backgroundColor = UIColor.white
        self.view = backView
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            maker.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension RecommendationItemsListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return recommendationItems.count
        } else {
            return hotrankingItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedlist", for: indexPath) as! RecommendedListCell
            cell.update(title: <#T##String#>, subtitle: <#T##String#>, price: <#T##Int#>)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotranking", for: indexPath) as! HotRankingCell
            return cell
        }
    }
}

extension RecommendationItemsListViewController: UICollectionViewDelegateFlowLayout {
    
}
