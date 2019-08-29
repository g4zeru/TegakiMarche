//
//  User.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/07.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Ballcap

extension FirebaseDatastore {
    @objcMembers
    final class User: Decodable, Modelable {
        dynamic var name: String = .init()
        dynamic var isBanned: Bool = false
        dynamic var email: String? = nil
    }
}

extension Document where Model: FirebaseDatastore.User {
    var profileImageStoragePath: StorageReference {
        return Storage.storage().reference().child("user").child(id).child("profileImage")
    }
}

extension FirebaseDatastore.User: FirebaseDatastoreQuery {
    static var baseQuery: DataSource<Document<FirebaseDatastore.User>>.Query {
        return Document<FirebaseDatastore.User>
            .where("isBanned", isEqualTo: false)
            .order(by: "updatedAt", descending: true)
    }
}
