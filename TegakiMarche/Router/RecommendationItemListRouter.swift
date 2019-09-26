//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 2:28.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import UIKit

protocol RecommendationItemListWireframe {
    func showDetailView(item: Firebase.PickupItem)
    func showUserDetailView(item: Firebase.User)
}

class RecommendationItemListRouter {
    private unowned let view: UIViewController

    private init(view: UIViewController) {
        self.view = view
    }

    static func assembleModules() -> UIViewController {
        let view = RecommendationItemsListViewController()
        let router = RecommendationItemListRouter(view: view)
        let errorInteractor = RecommendationItemListErrorInteractorImpl()
        let viewModel = MockReccomendationItemsListViewModel()
        let store = RecommendationItemsListStoreImpl(view: view,
                                                     router: router,
                                                     viewModel: viewModel,
                                                     errorInteractor: errorInteractor)
        view.store = store
        return view
    }
}

extension RecommendationItemListRouter: RecommendationItemListWireframe {
    func showDetailView(item: Firebase.PickupItem) {
        view.navigationController?.pushViewController(ItemDetailsViewController(item: item), animated: true)
    }

    func showUserDetailView(item: Firebase.User) {
        return
    }
}
