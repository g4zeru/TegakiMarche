//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 20:14.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore
import Foundation
import RxSwift

final class ObservableFirebaseQuery<Model: FirestoreDocumentModel> {
    private let query: Query

    init(query: Query) {
        self.query = query
    }

    func listen() -> Observable<[Model]> {
        return Observable<[Model]>.create { observer in
            self.query.addSnapshotListener { snapshot, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let snapshot = snapshot else {
                    observer.onError(FirestoreError.unknown)
                    return
                }
                let results = snapshot.documents.compactMap { document -> Model? in
                    do {
                        return try document.makeResult(id: document.documentID)
                    } catch {
                        return nil
                    }
                }
                observer.onNext(results)
            }
            return Disposables.create()
        }
    }

    func get() -> Observable<[Model]> {
        return Observable<[Model]>.create { observer in
            self.query.getDocuments { snapshot, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let snapshot = snapshot else {
                    observer.onError(FirestoreError.unknown)
                    return
                }
                let results = snapshot.documents.compactMap { document -> Model? in
                    do {
                        return try document.makeResult(id: document.documentID)
                    } catch {
                        return nil
                    }
                }
                observer.onNext(results)
            }
            return Disposables.create()
        }
    }

    func whereField(_ field: String, isEqualTo: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isEqualTo: isEqualTo))
    }
    func whereField(_ field: String, isGreaterThan: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isGreaterThan: isGreaterThan))
    }
    func whereField(_ field: String, isLessThan: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isLessThan: isLessThan))
    }
    func whereField(_ field: String, isGreaterThanOrEqualTo: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isGreaterThanOrEqualTo: isGreaterThanOrEqualTo))
    }
    func whereField(_ field: FieldPath, isEqualTo: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isEqualTo: isEqualTo))
    }
    func whereField(_ field: FieldPath, isGreaterThan: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isGreaterThan: isGreaterThan))
    }
    func whereField(_ field: FieldPath, isLessThan: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isLessThan: isLessThan))
    }
    func whereField(_ field: FieldPath, isGreaterThanOrEqualTo: Any) -> ObservableFirebaseQuery {
        return .init(query: self.query.whereField(field, isGreaterThanOrEqualTo: isGreaterThanOrEqualTo))
    }

    func order(by field: String) -> ObservableFirebaseQuery {
        return .init(query: self.query.order(by: field))
    }
    func order(by field: FieldPath) -> ObservableFirebaseQuery {
        return .init(query: self.query.order(by: field))
    }
    func order(by field: String, descending: Bool) -> ObservableFirebaseQuery {
        return .init(query: self.query.order(by: field, descending: descending))
    }
    func order(by field: FieldPath, descending: Bool) -> ObservableFirebaseQuery {
        return .init(query: self.query.order(by: field, descending: descending))
    }

    func limit(to: Int) -> ObservableFirebaseQuery {
        return .init(query: self.query.limit(to: to))
    }

    func asQuery() -> Query {
        return self.query
    }
}
