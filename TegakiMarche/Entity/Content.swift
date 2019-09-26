// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:31.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import FirebaseFirestore

extension Firebase {
    struct Content {
        enum ContentType: String {
            case audio
            case picture
        }
        private let id: String
        let title: String
        let thumbnailImageURL: URL
        let isPublished: Bool
        let type: ContentType
    }
}

extension Firebase.Content: FirestoreDocumentModel {
    var detailsRef: DocumentReference {
        return Firebase.Content.contentDoc(id: id, type: type)
    }
    
    static var baseQuery: ObservableFirebaseQuery<Firebase.Content> {
        return ObservableFirebaseQuery(query: collection)
    }
    
    init(id: String, timestamps: Timestamps, json: [String : Any]) throws {
        self.id = id
        self.title = try convert(target: parse(key: "title", json: json))
        self.thumbnailImageURL = try convert(target: parse(key: "thumbnail", json: json))
        self.isPublished = try convert(target: parse(key: "isPublished", json: json))
        let typeValue: String = try convert(target: parse(key: "type", json: json))
        self.type = ContentType(rawValue: typeValue)!
    }
    
    private static func contentDoc(id: String, type: ContentType) -> DocumentReference {
        return Firebase.baseRef.document("contentscontainer").collection(type.rawValue).document(id)
    }
}
