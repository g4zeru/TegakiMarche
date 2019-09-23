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
    
    init(viewController: ContentDetailsViewController, viewModel: ContentViewModel<Firebase.Content.Audio>) {
        viewModel.item
            .subscribe(onNext: { (audio) in
                viewController.contentView.image = UIImage(named: "demo")
            })
            .disposed(by: disposeBag)
    }
}
