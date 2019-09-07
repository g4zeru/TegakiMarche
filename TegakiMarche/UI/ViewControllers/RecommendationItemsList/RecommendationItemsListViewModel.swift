//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 0:00.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore
import Foundation
import RxRelay
import RxSwift

protocol RecommendationItemListInput {
}

protocol RecommendationItemListOutput {
    var recommendedItem: Observable<[Firebase.Item]> { get }
    var hotrankingItem: Observable<[Firebase.Item]> { get }
    var error: PublishRelay<Error> { get }
}

protocol RecommendationItemListViewModel {
    var input: RecommendationItemListInput { get }
    var output: RecommendationItemListOutput { get }
}

class RecommendationItemsListViewModelImpl: RecommendationItemListInput, RecommendationItemListOutput, RecommendationItemListViewModel {
    var recommendedItem: Observable<[Firebase.Item]> {
        return recommendedItemSubject
    }
    var hotrankingItem: Observable<[Firebase.Item]> {
        return hotrankingItemSubject
    }

    let recommendedItemSubject = PublishSubject<[Firebase.Item]>()
    let hotrankingItemSubject = PublishSubject<[Firebase.Item]>()
    let error: PublishRelay<Error> = PublishRelay()

    var input: RecommendationItemListInput {
        return self
    }

    var output: RecommendationItemListOutput {
        return self
    }

    private let disposeBag = DisposeBag()

    init() {
        Firebase.Item.baseQuery
            .limit(to: 4)
            .get()
            .bind(to: recommendedItemSubject)
            .disposed(by: disposeBag)
        Firebase.Item.baseQuery
            .limit(to: 2)
            .get()
            .bind(to: hotrankingItemSubject)
            .disposed(by: disposeBag)
    }
}
