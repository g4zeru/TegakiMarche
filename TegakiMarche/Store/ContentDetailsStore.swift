// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 22:12.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import RxSwift
import RxRelay

protocol ContentDetailsStore {
    var content: Observable<Firebase.Content> { get }
}

class ContentDetailsStoreImpl: ContentDetailsStore {
    let content: Observable<Firebase.Content> = PublishSubject()
    private let detailsViewModel = ContentViewModel<<#Model: ContentDocumentModel#>>()
    private let disposeBag = DisposeBag()
    init() {
        contentViewModel.output.content
            .subscribe(onNext: { content in
                content.detailsRef.get
            })
            .disposed(by: disposeBag)
    }
}
