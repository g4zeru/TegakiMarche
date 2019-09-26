// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 22:59.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore

extension Firebase.Content {
    struct SimpleUser {
        let name: String
        let profileImage: URL?
        let description: String?
    }
}

extension Firebase.Content.SimpleUser {
    init(json: [String : Any]) throws {
        self.name = try convert(target: parse(key: "name", json: json))
        if let imageURL: String = try? convert(target: parse(key: "profile", json: json)) {
            self.profileImage = URL(string: imageURL)
        } else {
            self.profileImage = nil
        }
        self.description = try? convert(target: parse(key: "description", json: json))
    }
}
