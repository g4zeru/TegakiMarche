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
    struct  User: FirestoreDocumentModel {
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
            self.isBanned = try convert(target: parse(key: "isBanned", json: json), Bool.self)
            self.email = try? convert(target: parse(key: "email", json: json), String.self)
        }
    }
}
