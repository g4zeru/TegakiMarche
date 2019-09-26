// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 19:09.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import FirebaseFirestore

extension Firebase.Content {
    struct Picture {
        let contentURL: URL
        let country: String?
        let description: String?
        let creator: DocumentReference
        let links: [Link]
    }
}

extension Firebase.Content.Picture: ContentDocumentModel {
    static var baseQuery: ObservableFirebaseQuery<Firebase.Content.Picture> {
        return ObservableFirebaseQuery<Firebase.Content.Picture>(query: collection)
    }
    
    init(id: String, timestamps: Timestamps, json: [String : Any]) throws {
        self.contentURL = URL(string: try convert(target: parse(key: "content", json: json)))!
        self.country = try? convert(target: parse(key: "country", json: json))
        self.description = try? convert(target: parse(key: "description", json: json))
        self.creator = Firebase.standardDatastore.collection("user").document(try convert(target: parse(key: "creatorID", json: json)))
        self.links = []
    }
}

extension Firebase.Content.Picture: MockContentDocumentModel {
    static var mock: Firebase.Content.Picture {
        return try! .init(id: "test", timestamps: Timestamps(createdAt: Date(), updatedAt: Date()), json: ["creatorID":"xdkenKit2s", "content": "https://i.ytimg.com/vi/WptXk39wiIQ/maxresdefault.jpg"])
    }
}
