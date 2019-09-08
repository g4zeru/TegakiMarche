// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 21:57.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import RxSwift
import RxRelay
import FirebaseFirestore

class MockReccomendationItemsListViewModel: RecommendationItemListInput, RecommendationItemListOutput, RecommendationItemListViewModel {
    let reflesh: PublishRelay<Void> = PublishRelay()
    
    var items: Observable<[Firebase.Item]> {
        return itemSubject
    }
    
    private let itemSubject: PublishSubject<[Firebase.Item]>
    
    let disposeBag = DisposeBag()
    
    var input: RecommendationItemListInput {
        return self
    }
    
    var output: RecommendationItemListOutput {
        return self
    }
    
    init() {
        let itemSubject = PublishSubject<[Firebase.Item]>()
        let json: [String: Any] = ["title":"ttt",
                                   "desc":"ddd",
                                   "publishedAt": Timestamp(date: Date.create(yyyyMMdd: "20170810")!),
                                   "imageURL":URL(string: "https://i-ogp.pximg.net/c/1050x550_80_a2_g2/img-master/img/2013/07/02/17/43/14/36786691_p0_master1200.jpg")!,
                                   "isPublished": true,
                                   "type":"pickup"]
        reflesh
            .subscribe(onNext: { _ in
                itemSubject.onNext([try! Firebase.Item(id: "xxx",
                                                       timestamps: Timestamps(createdAt: Date(),
                                                                              updatedAt: Date()),
                                                       json: json)])
            })
            .disposed(by: disposeBag)
        self.itemSubject = itemSubject
    }
}
