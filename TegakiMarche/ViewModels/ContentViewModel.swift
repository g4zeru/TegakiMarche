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

class ContentViewModel {
    var content: Observable<Firebase.Content> {
        return contentSubject
    }
    
    let audio: PublishRelay<Firebase.Content.Audio?> = PublishRelay()
    let picture: PublishRelay<Firebase.Content.Picture?> = PublishRelay()
    
    let contentSubject: PublishSubject<Firebase.Content> = PublishSubject()
    
    let disposeBag = DisposeBag()
    init() {
        content
            .subscribe(onNext: { [weak self] content in
                guard let self = self else {
                    return
                }
                switch content.type {
                case .audio:
                    ContentViewModel.accept(observer: self.audio, doc: content.detailsRef, disposeBag: self.disposeBag)
                case .picture:
                    ContentViewModel.accept(observer: self.picture, doc: content.detailsRef, disposeBag: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private static func accept<Model: ContentDocumentModel>(observer: PublishRelay<Model?>, doc: DocumentReference, disposeBag: DisposeBag) {
        let fetcher: Observable<Model> = ContentViewModel.get(doc: doc)
        fetcher
            .subscribe(onNext: { model in
                observer.accept(model)
            })
            .disposed(by: disposeBag)
    }
    
    private static func get<Model: ContentDocumentModel>(doc: DocumentReference) -> Observable<Model> {
        return Observable.create { observer in
            doc.getDocument { (snapshot, error) in
                if let error = error {
                    observer.onError(error)
                }
                guard let snapshot = snapshot else {
                    observer.onError(FirestoreError.unknown)
                    return
                }
                do {
                    observer.onNext( try snapshot.makeResult(id: snapshot.documentID))
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
