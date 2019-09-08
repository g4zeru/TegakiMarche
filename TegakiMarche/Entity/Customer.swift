//
//  User.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/07.
//

import FirebaseFirestore
import Foundation

extension Firebase {
    struct User {
        private let uniqueID: String
        let name: String
        let isBanned: Bool
        let email: String?
    }
}

extension Firebase.User: FirestoreDocumentModel {
    
    static var baseQuery: ObservableFirebaseQuery<Firebase.User> {
        return ObservableFirebaseQuery<Firebase.User>(query: collection)
    }
    init(id: String, timestamps: Timestamps, json: [String: Any]) throws {
        self.uniqueID = id
        self.name = try convert(target: parse(key: "name", json: json))
        self.isBanned = try convert(target: parse(key: "isBanned", json: json))
        self.email = try? convert(target: parse(key: "email", json: json))
    }
}
