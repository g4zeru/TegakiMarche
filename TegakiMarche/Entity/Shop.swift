//
//  Shop.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/08.
//

import FirebaseFirestore
import Foundation

extension Firebase {
    struct Shop: FirestoreDocumentModel {
        static var baseQuery: ObservableFirebaseQuery<Shop> {
            return ObservableFirebaseQuery<Shop>(query: collection)
                .whereField("isPublished", isEqualTo: true)
                .whereField("isBanned", isEqualTo: false)
                .order(by: "publishedAt", descending: true)
        }

        let name: String
        let desc: String?
        let ownerID: String
        let isPublished: Bool
        let publishedAt: Date
        
        var items: CollectionReference {
            return Shop.collection.document(identity.id).collection("item")
        }

        let identity: FirestoreIdentity

        init(identity: FirestoreIdentity, json: [String: Any]) throws {
            self.identity = identity
            self.name = try convert(target: parse(key: "name", json: json), String.self)
            self.desc = try? convert(target: parse(key: "desc", json: json), String.self)
            self.ownerID = try convert(target: parse(key: "ownerID", json: json), String.self)
            self.isPublished = try convert(target: parse(key: "isPublished", json: json), Bool.self)
            self.publishedAt = try convert(target: parse(key: "publishedAt", json: json), Timestamp.self).dateValue()
        }
    }
}

extension Firebase.Shop {
}
