//
//  User.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/07.
//

import FirebaseFirestore
import Foundation

extension Firebase {
    struct  User: FirestoreDocumentModel {
        static var baseQuery: ObservableFirebaseQuery<Firebase.User> {
            return ObservableFirebaseQuery<Firebase.User>(query: collection)
        }

        let name: String
        let isBanned: Bool
        let email: String?

        let identity: FirestoreIdentity

        init(identity: FirestoreIdentity, json: [String: Any]) throws {
            self.identity = identity
            self.name = try convert(target: parse(key: "name", json: json), String.self)
            self.isBanned = try convert(target: parse(key: "isBanned", json: json), Bool.self)
            self.email = try? convert(target: parse(key: "email", json: json), String.self)
        }
    }
}
