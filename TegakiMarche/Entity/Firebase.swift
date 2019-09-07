//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 3:14.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore
import RxSwift

struct Firebase {
    static let baseRef = Firestore.firestore().collection("datastore")
    static var standardDatastore: DocumentReference {
        return baseRef.document("v1")
    }
}

struct FirestoreIdentity {
    let id: String
    let createdAt: Date
    var updatedAt: Date
}

protocol FirestoreDocumentModel: ReactiveCompatible {
    static var baseQuery: ObservableFirebaseQuery<Self> { get }
    static var collection: CollectionReference { get }

    init (identity: FirestoreIdentity, json: [String: Any]) throws
}

extension FirestoreDocumentModel {
    static var collection: CollectionReference {
        return Firebase.standardDatastore.collection(String(describing: Self.self).lowercased())
    }

    static func document(id: String) -> DocumentReference {
        return collection.document(id)
    }
}

extension Reactive where Base: FirestoreDocumentModel {
    static func listen(documentID id: String) -> Observable<Base> {
        return Observable.create { observer in
            Base.document(id: id).addSnapshotListener { snapshot, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let snapshot = snapshot else {
                    observer.onError(FirestoreError.unknown)
                    return
                }
                do {
                    observer.onNext(try snapshot.makeResult(id: snapshot.documentID))
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    static func listenCollection() -> Observable<[Base]> {
        return listen(query: Base.collection.order(by: "updatedAt", descending: true))
    }

    static func listen(query: Query) -> Observable<[Base]> {
        return Observable.create { observer in
            query.addSnapshotListener { snapshot, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let snapshot = snapshot else {
                    observer.onError(FirestoreError.unknown)
                    return
                }
                let results = snapshot.documents.compactMap { document -> Base? in
                    do {
                        return try document.makeResult(id: document.documentID)
                    } catch {
                        observer.onError(error)
                        return nil
                    }
                }
                observer.onNext(results)
            }
            return Disposables.create()
        }
    }
}

extension Reactive where Base: Query {
    static func listen<T: FirestoreDocumentModel>() -> Observable<[T]> {
        return Observable.create({ _ in
            Disposables.create()
        })
    }
}

/*
 protocol FirebaseDatastoreQuery: Modelable & Codable {
 typealias DatastoreQuery = DataSource<Document<Self>>

 static var baseQuery: DatastoreQuery.Query { get }
 }*/

enum FirestoreError: Error {
    case unknown
    case notFoundEntity(documentID: String)
    case convert(data: Any)
    case parse(key: String)
}

extension DocumentSnapshot {
    func makeResult<T: FirestoreDocumentModel>(id: String) throws -> T {
        guard exists else {
            throw FirestoreError.notFoundEntity(documentID: documentID)
        }
        let json = data() ?? [:]
        guard let createdAt = json["createdAt"] as? Timestamp, let updatedAt = json["updatedAt"] as? Timestamp else {
            throw FirestoreError.notFoundEntity(documentID: documentID)
        }
        let identity = FirestoreIdentity(id: documentID, createdAt: createdAt.dateValue(), updatedAt: updatedAt.dateValue())
        return try T(identity: identity, json: json)
    }
}

func parse(key: String, json: [String: Any]) throws -> Any {
    guard let parsedData = json[key] else {
        throw FirestoreError.parse(key: key)
    }
    return parsedData
}

func convert<T>(target: Any) throws -> T {
    guard let castedObject = target as? T else {
        throw FirestoreError.convert(data: target)
    }
    return castedObject
}
