// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:31.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation

extension Firebase {
    struct Content {
        enum ContentType {
            case audio
            case illust
            case photo
        }
        let title: String
        let thubmnailImageURL: URL
        let contentURL: URL
        let isPublished: Bool
    }
}

extension Firebase.Content: FirestoreDocumentModel {
    static var baseQuery: ObservableFirebaseQuery<Firebase.Content> {
        return ObservableFirebaseQuery(query: collection)
    }
    
    init(id: String, timestamps: Timestamps, json: [String : Any]) throws {
        self.title = try convert(target: parse(key: "title", json: json))
        self.thubmnailImageURL = try convert(target: parse(key: "thubmnail", json: json))
        self.contentURL = try convert(target: parse(key: "content", json: json))
        self.isPublished = try convert(target: parse(key: "isPublished", json: json))
    }
}
