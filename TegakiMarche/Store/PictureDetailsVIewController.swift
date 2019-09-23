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
    
    init(viewController: ContentDetailsViewController, viewModel: ContentViewModel<Firebase.Content.Picture>) {
        viewModel.item
            .subscribe(onNext: { (picture) in
                print(picture)
                viewController.contentView.image = UIImage(named: "demo")
            })
            .disposed(by: disposeBag)
    }
}
