// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 18:28.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import Instantiate
import RxSwift
import RxCocoa

class PictureDetailsStore: ContentDetailsStore {
    
    let loadingRelay: PublishRelay<Bool> = .init()
    
    let disposeBag = DisposeBag()
    
    var loading: Driver<Bool> {
        return loadingRelay.asDriver(onErrorJustReturn: false)
    }
    
    init(content: Firebase.Content, viewController: ContentDetailsViewControllerProtocol, viewModel: ContentViewModel<Firebase.Content.Picture>) {
        viewModel.item
            .subscribe(onNext: { (picture) in
                UIImage.fetchImage(url: picture.contentURL) { (result) in
                    guard case .success(let image) = result else {
                        return
                    }
                    viewController.updateImage(image)
                }
                viewController.insertStackContent(view: DetailTextView.instantiate(with: content.title), at: 1)
            })
            .disposed(by: disposeBag)
    }
}
