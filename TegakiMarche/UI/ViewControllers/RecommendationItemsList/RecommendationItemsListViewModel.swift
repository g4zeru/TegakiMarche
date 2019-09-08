//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 0:00.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore
import Foundation
import RxRelay
import RxSwift

protocol RecommendationItemListInput {
    var reflesh: PublishRelay<Void> { get }
}

protocol RecommendationItemListOutput {
    var items: Observable<[Firebase.Item]> { get }
}

protocol RecommendationItemListViewModel {
    var input: RecommendationItemListInput { get }
    var output: RecommendationItemListOutput { get }
}

final class RecommendationItemsListViewModelImpl: RecommendationItemListInput, RecommendationItemListOutput, RecommendationItemListViewModel {
    let reflesh: PublishRelay<Void> = PublishRelay()
    
    var items: Observable<[Firebase.Item]> {
        return itemSubject
    }

    let itemSubject = PublishSubject<[Firebase.Item]>()

    var input: RecommendationItemListInput {
        return self
    }

    var output: RecommendationItemListOutput {
        return self
    }

    private let disposeBag = DisposeBag()

    init(itemQuery: ObservableFirebaseQuery<Firebase.Item>) {
        reflesh
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                itemQuery
                    .get()
                    .bind(to: self.itemSubject)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
