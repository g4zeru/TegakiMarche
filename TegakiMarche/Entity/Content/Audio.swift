// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 19:08.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import FirebaseFirestore

extension Firebase.Content {
    struct Audio {
        let audioURL: URL
    }
}

extension Firebase.Content.Audio: ContentDocumentModel {
    static var baseQuery: ObservableFirebaseQuery<Firebase.Content.Audio> {
        return ObservableFirebaseQuery<Firebase.Content.Audio>(query: collection)
    }
    
    init(id: String, timestamps: Timestamps, json: [String : Any]) throws {
        self.audioURL = URL(string: try convert(target: parse(key: "audioURL", json: json)))!
    }
}

extension Firebase.Content.Audio: MockContentDocumentModel {
    static var mock: Firebase.Content.Audio {
        return try! .init(id: "test", timestamps: Timestamps(createdAt: Date(), updatedAt: Date()), json: ["audioURL": "https://google.com"])
    }
}
