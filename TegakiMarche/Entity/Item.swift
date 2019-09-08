//
//  Item.swift
//  TegakiMarche
//
//  Created by iniad on 2019/07/08.
//

import FirebaseFirestore
import RxSwift

extension Firebase {
    struct Item: FirestoreDocumentModel {
        
        enum ContentType: String {
            case pickup
            case column
            case wallpaper
        }
        
        enum AdditionalContent: FirestoreDocumentModel {
            private enum ContentType: String {
                case text
                case image
            }
            
            static var baseQuery: ObservableFirebaseQuery<Firebase.Item.AdditionalContent> {
                return .init(query: Item.collection.document().collection("contents"))
            }
            
            case text(String)
            case image(URL)
            
            init(identity: FirestoreIdentity, json: [String : Any]) throws {
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
                return Item.collection.document(id).collection("contents")
            }
        }
        
        static var baseQuery: ObservableFirebaseQuery<Item> {
            return ObservableFirebaseQuery<Item>(query: collection)
                .whereField("isPublished", isEqualTo: true)
                .order(by: "publishedAt", descending: true)
        }

        let title: String
        let subTitle: String?
        let isPublished: Bool
        let publishedAt: Date
        let thumbnailImagePath: String?
        let createdAt: Date
        let updatedAt: Date
        let id: String
        let type: ContentType

        init(identity: FirestoreIdentity, json: [String: Any]) throws {
            self.title = try convert(target: parse(key: "title", json: json))
            self.subTitle = try? convert(target: parse(key: "desc", json: json))
            let timestamp: Timestamp = try convert(target: parse(key: "publishedAt", json: json))
            self.publishedAt = timestamp.dateValue()
            self.isPublished = try convert(target: parse(key: "isPublished", json: json))
            self.thumbnailImagePath = nil
            self.createdAt = identity.createdAt
            self.updatedAt = identity.updatedAt
            self.id = identity.id
            self.type = try Item.contentType(json: json)
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
}
