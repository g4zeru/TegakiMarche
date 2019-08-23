// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 3:14.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import Firebase

class FirebaseDatastore {
    static let baseRef = Firestore.firestore().collection("datastore")
    static var standardDatastore: DocumentReference {
        return baseRef.document("v1")
    }
}
