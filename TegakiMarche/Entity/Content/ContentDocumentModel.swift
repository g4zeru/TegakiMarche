// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 23:27.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import FirebaseFirestore

protocol ContentDocumentModel: FirestoreDocumentModel {}

protocol MockContentDocumentModel: ContentDocumentModel {
    static var mock: Self { get }
}

extension ContentDocumentModel {
    static var collection: CollectionReference {
        return Firebase.contentsDatastore.collection(String(describing: Self.self).lowercased())
    }
    static func document(id: String) -> DocumentReference {
        return collection.document(id)
    }
}
