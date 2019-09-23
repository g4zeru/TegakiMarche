// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 23:03.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import RxSwift
import RxRelay
import FirebaseFirestore

class ContentViewModel<Model: MockContentDocumentModel> {
    var item: Observable<Model> {
        return itemSubject
    }
    private let itemSubject: PublishSubject<Model> = PublishSubject()
    
    let disposeBag = DisposeBag()
    init(docRef: DocumentReference) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.itemSubject.onNext(.mock)
        }
        //docRef.rx.get().bind(to: self.itemSubject).disposed(by: self.disposeBag)
    }
}
