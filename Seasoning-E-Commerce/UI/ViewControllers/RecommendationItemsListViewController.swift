//
//  RecommendationItemsListViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit
import SnapKit

class RecommendationItemsListViewController: UIViewController {
    var recommendationItems: [Item] = [Item(title: "自家農園産自然栽培原料•低温圧搾生搾り黒ごま油110g",
                                            description: "自然栽培で育てた生命力溢れる落花生を使用した最高級油です。",
                                            price: 1300,
                                            rate: 4.7,
                                            image: URL(string: "https://images-na.ssl-images-amazon.com/images/I/61X%2BmhmmooL.jpg")!),
                                       Item(title: "三河産大豆の八丁味噌",
                                            description: "伝統製法で造り続けている豆みその銘柄",
                                            price: 900,
                                            rate: 3.5,
                                            image: URL(string: "https://image.excite.co.jp/jp/erecipe/recipe/9/1/91e4ba3667cde1e9111b51d2d6665fc1/147e90fc3c338c69b76b80d7f59b0853.jpeg")!)]
    var hotrankingItems: [Item] = [Item(title: "アカシアボウル-14cm",
                                        description: "アメリカンドリームを手にした日本人が作ったグルメソース。",
                                        price: 1300,
                                        rate: 4.7,
                                        image: URL(string: "https://image.rakuten.co.jp/air-rhizome/cabinet/7/aks112.jpg")!),
                                   Item(title: "備前焼スパゲティー皿",
                                        description: "伝統製法で造り続けている豆みその銘柄",
                                        price: 1800,
                                        rate: 3.5,
                                        image: URL(string: "https://image.rakuten.co.jp/mhomestyle/cabinet/bbbbbbbbbbb/04185669/imgrc0071002055.jpg")!),
                                   Item(title: "塩レモンパスタソース2人前",                                            description: "アメリカンドリームを手にした日本人が作ったグルメソース。",
                                        price: 540,
                                        rate: 4.7,
                                        image: URL(string: "https://dbcn1bdvswqbx.cloudfront.net/client_info/KALDI/itemimage/4515996905971.jpg")!),
                                   Item(title: "三河産大豆の八丁味噌",
                                        description: "伝統製法で造り続けている豆みその銘柄",
                                        price: 400,
                                        rate: 3.5,
                                        image: URL(string: "https://www.asunal.jp/image/asunal/store/storage/w403/cname_20170928160824.jpg")!)]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 35, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.register(UINib(nibName: "RecommendedListCell", bundle: nil), forCellWithReuseIdentifier: "recommendedlist")
        view.register(UINib(nibName: "HotRankingCell", bundle: nil), forCellWithReuseIdentifier: "hotranking")
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
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedlist", for: indexPath) as! RecommendedListCell
            cell.update(item: recommendationItems[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotranking", for: indexPath) as! HotRankingCell
            cell.update(item: hotrankingItems[indexPath.item])
            return cell
        }
    }
}

extension RecommendationItemsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let contentWidth = collectionView.frame.width - margin * 2
        if indexPath.section == 0 {
            return CGSize(width: contentWidth, height: contentWidth * RecommendedListCell.cellHeightRatio)
        } else {
            let contentMargin: CGFloat = 20
            let width = (contentWidth - contentMargin) / 2
            return CGSize(width: width, height: width * HotRankingCell.cellHeightRatio)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "listheader", for: indexPath) as! ListHeaderView
            if indexPath.section == 0 {
                header.update(title: "Daily choice")
            } else {
                header.update(title: "Weekly Ranking")
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
