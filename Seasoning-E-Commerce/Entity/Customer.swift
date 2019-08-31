//
//  User.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/07.
//

import Ballcap
import FirebaseFirestore
import FirebaseStorage
import Foundation

extension Firebase {
    @objcMembers
    final class User: FirestoreDocumentModel {
        static var baseQuery: Query {
            return Firebase.standardDatastore.collection("user")
        }

        dynamic var name: String = .init()
        dynamic var isBanned: Bool = false
        dynamic var email: String?

        let identity: FirestoreIdentity

        init(identity: FirestoreIdentity, json: [String: Any]) throws {
            self.identity = identity
            self.name = try convert(target: parse(key: "name", json: json), String.self)
        }
    }
}

/*
 extension FirebaseDatastore.User: FirebaseDatastoreQuery {
 static var baseQuery: DataSource<Document<FirebaseDatastore.User>>.Query {
 return Document<FirebaseDatastore.User>
 .where("isBanned", isEqualTo: false)
 .order(by: "updatedAt", descending: true)
 }
 }
 */
