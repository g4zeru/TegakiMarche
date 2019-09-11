//
//  Item.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/08.
//

import FirebaseFirestore
import RxSwift

extension Firebase {
    struct PickupItem {
        enum ContentType: String {
            case pickup
            case column
            case wallpaper
        }

        enum AdditionalContent {
            case text(String)
            case image(URL)
        }
        private let uniqueID: String
        let title: String
        let subTitle: String?
        let isPublished: Bool
        let publishedAt: Date
        let thumbnailImagePath: URL?
        let type: ContentType
    }
}

extension Firebase.PickupItem: FirestoreDocumentModel {
    static var baseQuery: ObservableFirebaseQuery<Firebase.PickupItem> {
        return ObservableFirebaseQuery<Firebase.PickupItem>(query: collection)
            .whereField("isPublished", isEqualTo: true)
            .order(by: "publishedAt", descending: true)
    }
    
    init(id: String, timestamps: Timestamps, json: [String: Any]) throws {
        self.uniqueID = id
        self.title = try convert(target: parse(key: "title", json: json))
        self.subTitle = try? convert(target: parse(key: "desc", json: json))
        let publishedAt: Timestamp = try convert(target: parse(key: "publishedAt", json: json))
        self.publishedAt = publishedAt.dateValue()
        self.isPublished = try convert(target: parse(key: "isPublished", json: json))
        self.thumbnailImagePath = try? convert(target: parse(key: "imageURL", json: json))
        self.type = try Firebase.PickupItem.contentType(json: json)
    }
    
    static func contentType(json: [String: Any]) throws -> ContentType {
        guard let parsedText: String = try? convert(target: parse(key: "type", json: json)) else {
            throw FirestoreError.parse(key: "type")
        }
        guard let type: ContentType = ContentType.init(rawValue: parsedText) else {
            throw FirestoreError.unknown
        }
        return type
    }
    
}

extension Firebase.PickupItem.AdditionalContent: FirestoreDocumentModel {
    private enum ContentType: String {
        case text
        case image
    }
    
    static var baseQuery: ObservableFirebaseQuery<Firebase.PickupItem.AdditionalContent> {
        return .init(query: Firebase.PickupItem.collection.document().collection("contents"))
    }
    
    init(id: String, timestamps: Timestamps, json: [String: Any]) throws {
        guard let parsedText: String = try? convert(target: parse(key: "type", json: json)) else {
            throw FirestoreError.parse(key: "type")
        }
        let contentType: ContentType? = ContentType.init(rawValue: parsedText)
        switch contentType {
        case .some(.image):
            self = .image(try convert(target: parse(key: "body", json: json)))
        case .some(.text):
            self = .text(try convert(target: parse(key: "body", json: json)))
        case .none:
            throw FirestoreError.unknown
        }
    }
    
    static func collectionRef(id: String) -> CollectionReference {
        return Firebase.PickupItem.collection.document(id).collection("contents")
    }
}
