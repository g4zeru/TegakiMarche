// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 23:02.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore

extension Firebase.Content {
    enum Link {
        case amazon(id: String)
        case youtube(id: String)
        case unsplash(id: String)
        case pixiv(id: String)
        case twitter(id: String)
        
        var link: URL {
            let urlString: String
            switch self {
            case .amazon(id: let id):
                urlString = "https://youtube.com/\(id)"
            case .pixiv(id: let id):
                urlString = "https://youtube.com/\(id)"
            case .unsplash(id: let id):
                urlString = "https://youtube.com/\(id)"
            case .youtube(id: let id):
                urlString = "https://youtube.com/\(id)"
            case .twitter(id: let id):
                urlString = "https://youtube.com/\(id)"
            }
            return URL(string: urlString)!
        }
    }
}
