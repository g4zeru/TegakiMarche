//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 2:34.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation

protocol RecommendationItemListErrorInteractor {
    func handle(error: Error) -> String
}

class RecommendationItemListErrorInteractorImpl: RecommendationItemListErrorInteractor {
    func handle(error: Error) -> String {
        debugPrint(error)
        guard let error = error as? FirestoreError else {
            return "unknown"
        }
        switch error {
        case .convert(data: _):
            return "データの取得に失敗しました"
        case .parse(key: _):
            return "データの取得に失敗しました"
        case .notFoundEntity(documentID: _):
            return "データの取得に失敗しました"
        case .unknown:
            return "unknown"
        }
    }
}
