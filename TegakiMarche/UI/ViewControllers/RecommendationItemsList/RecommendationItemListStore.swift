//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 1:12.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import RxRelay
import RxSwift

protocol RecommendationItemsListStore {
    var shouldRealoadData: PublishRelay<Int> { get }
    var recommendedItem: [Firebase.Item] { get }
    var hotrankingItem: [Firebase.Item] { get }

    func selectRecommendedItem(index: Int)
    func selectHotRankingItem(index: Int)
    func selectShopDetail(shop: Firebase.Shop)
}

class RecommendationItemsListStoreImpl: RecommendationItemsListStore {
    var hotrankingItem: [Firebase.Item] {
        return hotrankingItemRelay.value
    }
    var recommendedItem: [Firebase.Item] {
        return recommendedItemRelay.value
    }

    var shouldRealoadData: PublishRelay<Int> = PublishRelay()

    private weak var view: RecommendationItemsListViewController?
    private var viewModel: RecommendationItemListViewModel
    private var router: RecommendationItemListWireframe
    private var errorInteractor: RecommendationItemListErrorInteractor

    private let recommendedItemRelay: BehaviorRelay<[Firebase.Item]> = BehaviorRelay(value: [])
    private let hotrankingItemRelay: BehaviorRelay<[Firebase.Item]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    init(
        view: RecommendationItemsListViewController,
        router: RecommendationItemListWireframe,
        viewModel: RecommendationItemListViewModel,
        errorInteractor: RecommendationItemListErrorInteractor
        ) {
        self.viewModel = viewModel
        self.view = view
        self.router = router
        self.errorInteractor = errorInteractor
        viewModel.output.recommendedItem
            .catchError({ error -> Observable<[Firebase.Item]> in
                view.showErrorMessage(text:
                    errorInteractor.handle(error: error)
                )
                return Observable.just([])
            })
            .bind(to: recommendedItemRelay)
            .disposed(by: disposeBag)
        viewModel.output.hotrankingItem
            .catchError({ error -> Observable<[Firebase.Item]> in
                view.showErrorMessage(text:
                    errorInteractor.handle(error: error)
                )
                return Observable.just([])
            })
            .bind(to: hotrankingItemRelay)
            .disposed(by: disposeBag)
        recommendedItemRelay
            .subscribe(onNext: { [weak self] _ in
                self?.shouldRealoadData.accept(0)
            })
            .disposed(by: disposeBag)
        hotrankingItemRelay
            .subscribe(onNext: { [weak self] _ in
                self?.shouldRealoadData.accept(1)
            })
            .disposed(by: disposeBag)
    }

    func selectRecommendedItem(index: Int) {
        router.showDetailView(item: self.recommendedItemRelay.value[index])
    }

    func selectHotRankingItem(index: Int) {
        router.showDetailView(item: self.hotrankingItemRelay.value[index])
    }

    func selectShopDetail(shop: Firebase.Shop) {
        // Todo: 未実装
        return
    }
}
