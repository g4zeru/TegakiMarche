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

protocol ContentViewModelProtocol {
    associatedtype Dependency: ContentDocumentModel
    var item: Observable<Dependency> { get }
    init(docRef: DocumentReference)
}

class MockContentViewModel<Model: MockContentDocumentModel>: ContentViewModel<Model> {
    override var item: Observable<Model> {
        return self.itemSubject
    }
    private let itemSubject: PublishSubject<Model> = PublishSubject()
    override func fetch() {
        print("fetch")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.itemSubject.onNext(.mock)
        }
    }
}

class ContentViewModel<Model: ContentDocumentModel> {
    var item: Observable<Model> {
        return itemSubject
    }
    private let itemSubject: PublishSubject<Model> = PublishSubject()
    
    let disposeBag = DisposeBag()
    let ref: DocumentReference
    init(docRef: DocumentReference) {
        ref = docRef
        fetch()
    }
    
    func fetch() {
        ref.rx.get().bind(to: self.itemSubject).disposed(by: self.disposeBag)
    }
}
