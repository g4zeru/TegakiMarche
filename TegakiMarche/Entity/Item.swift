//
//  Item.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/08.
//

import FirebaseFirestore

extension Firebase {
    struct Item: FirestoreDocumentModel {
        static var baseQuery: ObservableFirebaseQuery<Item> {
            return ObservableFirebaseQuery<Item>(query: collection)
                .whereField("isPublished", isEqualTo: true)
                .order(by: "publishedAt", descending: true)
        }

        dynamic var title: String = ""
        dynamic var desc: String = ""
        dynamic var price: Int = 0
        dynamic var isPublished: Bool = true
        dynamic var publishedAt = Date()
        dynamic var imagePath: String? = ""
        dynamic var images: [String: Any] = [:]

        let identity: FirestoreIdentity

        init(identity: FirestoreIdentity, json: [String: Any]) throws {
            self.identity = identity
            self.title = try convert(target: parse(key: "title", json: json), String.self)
            self.desc = (try? convert(target: parse(key: "desc", json: json), String.self)) ?? ""
            self.price = try convert(target: parse(key: "price", json: json), Int.self)
            self.publishedAt = try convert(target: parse(key: "publishedAt", json: json), Timestamp.self).dateValue()
        }
    }
}
