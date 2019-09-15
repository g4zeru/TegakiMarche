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
    }
}

extension Firebase.Content.Picture: ContentDocumentModel {
    static var baseQuery: ObservableFirebaseQuery<Firebase.Content.Picture> {
        return ObservableFirebaseQuery<Firebase.Content.Picture>(query: collection)
    }
    
    init(id: String, timestamps: Timestamps, json: [String : Any]) throws {
        
    }
}
