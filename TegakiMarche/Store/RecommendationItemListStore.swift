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
    var items: BehaviorRelay<[Firebase.PickupItem]> { get }

    func select(index: Int)
    func reflesh()
}

class RecommendationItemsListStoreImpl: RecommendationItemsListStore {
    
    let items: BehaviorRelay<[Firebase.PickupItem]> = .init(value: [])

    var shouldRealoadData: PublishRelay<Int> = PublishRelay()

    private weak var view: RecommendationItemsListViewController?
    private var viewModel: RecommendationItemListViewModel
    private var router: RecommendationItemListWireframe
    private var errorInteractor: RecommendationItemListErrorInteractor

    private let itemRelay: BehaviorRelay<[Firebase.PickupItem]> = BehaviorRelay(value: [])

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
        viewModel.output.items
            .catchError({ error -> Observable<[Firebase.PickupItem]> in
                view.showErrorMessage(text:
                    errorInteractor.handle(error: error)
                )
                return Observable.just([])
            })
            .bind(to: itemRelay)
            .disposed(by: disposeBag)
        itemRelay
            .bind(to: items)
            .disposed(by: disposeBag)
    }

    func select(index: Int) {
        router.showDetailView(item: self.itemRelay.value[index])
    }
    
    func reflesh() {
        viewModel.input.reflesh.accept(())
    }
}
