// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 18:26.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import Instantiate
import RxSwift
import RxCocoa

class AudioDetailsStore: ContentDetailsStore {
    let loadingRelay: PublishRelay<Bool> = .init()
    
    let disposeBag = DisposeBag()
    
    var loading: Driver<Bool> {
        return loadingRelay.asDriver(onErrorJustReturn: false)
    }
    
    init(content: Firebase.Content, viewController: ContentDetailsViewControllerProtocol, viewModel: ContentViewModel<Firebase.Content.Audio>) {
        viewModel.item
            .subscribe(onNext: { (audio) in
                UIImage.fetchImage(url: content.thumbnailImageURL) { (result) in
                    switch result {
                    case .success(let image):
                        viewController.updateImage(image)
                    case .failure(let error):
                        developDebugPrint(error)
                    }
                }
                viewController.insertStackContent(view: ContentDetailsViewBuilder.audio(), at: 0)
                viewController.insertStackContent(view: DetailTextView.instantiate(with: content.title), at: 1)
            })
            .disposed(by: disposeBag)
    }
}
