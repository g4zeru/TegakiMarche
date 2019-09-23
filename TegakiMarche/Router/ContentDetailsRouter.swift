// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:57.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate

class ContentDetailsRouter {
    static func assembleModules(content: Firebase.Content) -> UIViewController {
        let viewController = ContentDetailsRouter.view(content: content)
        return viewController
    }
    
    private static func view(content: Firebase.Content) -> ContentDetailsViewController {
        let view = ContentDetailsViewController.instantiate(with: content)
        let store: ContentDetailsStore
        switch content.type {
        case .audio:
            store = AudioDetailsStore(viewController: view, viewModel: .init(docRef: content.detailsRef))
        case .picture:
            store = PictureDetailsStore(viewController: view, viewModel: .init(docRef: content.detailsRef))
        }
        view.store = store
        return view
    }
}
