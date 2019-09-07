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
    var refleshRecommendedItem: PublishRelay<Void> { get }
    var refleshHotrankingItem: PublishRelay<Void> { get }
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

final class RecommendationItemsListViewModelImpl: RecommendationItemListInput, RecommendationItemListOutput, RecommendationItemListViewModel {
    let refleshRecommendedItem: PublishRelay<Void> = PublishRelay()
    
    let refleshHotrankingItem: PublishRelay<Void> = PublishRelay()
    
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

    init(recommendedItemQuery: ObservableFirebaseQuery<Firebase.Item>,
         hotrankingItemQuery: ObservableFirebaseQuery<Firebase.Item>) {
        refleshRecommendedItem
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                recommendedItemQuery
                    .get()
                    .bind(to: self.recommendedItemSubject)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        refleshHotrankingItem
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                hotrankingItemQuery
                    .get()
                    .bind(to: self.hotrankingItemSubject)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}
