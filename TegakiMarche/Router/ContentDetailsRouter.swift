// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:57.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate
import FirebaseFirestore

class ContentDetailsRouter {
    static func assembleModules(content: Firebase.Content) -> UIViewController {
        let viewController = ContentDetailsRouter.view(content: content)
        return viewController
    }
    
    private static func view(content: Firebase.Content) -> ContentDetailsViewController {
        let view = ContentDetailsViewController.instantiate()
        let store: ContentDetailsStore = ContentDetailsRouter.mock(content: content, view: view)
        view.store = store
        return view
    }
    
    static func store(content: Firebase.Content, view: ContentDetailsViewControllerProtocol) -> ContentDetailsStore {
        switch content.type {
        case .audio:
            return AudioDetailsStore(content: content,viewController: view, viewModel: ContentViewModel(docRef: content.detailsRef))
        case .picture:
            return PictureDetailsStore(content: content,viewController: view, viewModel: ContentViewModel(docRef: content.detailsRef))
        }
    }
    
    static func mock(content: Firebase.Content, view: ContentDetailsViewControllerProtocol) -> ContentDetailsStore {
        switch content.type {
        case .audio:
            return AudioDetailsStore(content: content,viewController: view, viewModel: MockContentViewModel(docRef: content.detailsRef))
        case .picture:
            return PictureDetailsStore(content: content,viewController: view, viewModel: MockContentViewModel(docRef: content.detailsRef))
        }
    }
}
