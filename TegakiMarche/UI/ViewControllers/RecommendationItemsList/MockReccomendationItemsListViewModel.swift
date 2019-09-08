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
        let json1: [String: Any] = ["title":"夏の思い出特集！",
                                   "desc":"夏の思い出をTegakiMarcheでも作ろう",
                                   "publishedAt": Timestamp(date: Date.create(yyyyMMdd: "20170810")!),
                                   "imageURL":URL(string: "https://images.unsplash.com/photo-1520322082799-20c1288346e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80")!,
                                   "isPublished": true,
                                   "type":"pickup"]
        let json2: [String: Any] = ["title":"Daily choice",
                                    "desc":"iPhoneXR, iPhoneXS Max",
                                    "publishedAt": Timestamp(date: Date.create(yyyyMMdd: "20170810")!),
                                    "imageURL":URL(string: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80")!,
                                    "isPublished": true,
                                    "type":"wallpaper"]
        reflesh
            .subscribe(onNext: { _ in
                itemSubject.onNext([try! Firebase.Item(id: "xxx",
                                                       timestamps: Timestamps(createdAt: Date(),
                                                                              updatedAt: Date()),
                                                       json: json1),
                                    try! Firebase.Item(id: "sss",
                                                       timestamps: Timestamps(createdAt: Date(),
                                                                              updatedAt: Date()),
                                                       json: json2)])
            })
            .disposed(by: disposeBag)
        self.itemSubject = itemSubject
    }
}
