//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 3:14.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Ballcap
import Firebase
import Foundation

struct FirebaseDatastore {
    static let baseRef = Firestore.firestore().collection("datastore")
    static var standardDatastore: DocumentReference {
        return baseRef.document("v1")
    }
}

protocol FirebaseDatastoreQuery: Modelable & Codable {
    typealias DatastoreQuery = DataSource<Document<Self>>

    static var baseQuery: DatastoreQuery.Query { get }
}
