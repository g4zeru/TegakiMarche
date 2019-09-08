//
//  RecommendationItemsListViewController.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/15.
//

import RxSwift
import UIKit

protocol RecommendationItemsListView {
    func showErrorMessage(text: String)
}

class RecommendationItemsListViewController: UIViewController, RecommendationItemsListView {
    var store: RecommendationItemsListStoreImpl!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 35, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.register(UINib(nibName: "ListHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "listheader")
        return view
    }()
    private let errorView = ErrorMessageView()

    let disposeBag = DisposeBag()

    override func loadView() {
        let backView = UIView(frame: UIScreen.main.bounds)
        backView.backgroundColor = UIColor.white
        self.view = backView
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.errorView)
        self.collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            maker.trailing.equalToSuperview()
        }
        self.errorView.snp.makeConstraints { maker in
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(50)
        }
        self.errorView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.items
            .subscribe(onNext: { items in
                print(items.count)
            })
            .disposed(by: disposeBag)
        
        rx.sentMessage(#selector(viewDidAppear(_:)))
            .subscribe(onNext: { [weak self] _ in
                self?.store.reflesh()
            })
            .disposed(by: disposeBag)
        
    }

    func showErrorMessage(text: String) {
        guard self.errorView.isHidden else {
            return
        }
        self.errorView.label.text = text
        self.errorView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.errorView.isHidden = true
        }
    }
}
