//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 2:51.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import FirebaseFirestore
import Foundation
import RxRelay
import RxSwift

protocol CreateShopViewModelInputs {
    var name: BehaviorRelay<String> { get }
    var description: BehaviorRelay<String> { get }
    var email: BehaviorRelay<String> { get }
    var isCurrentEmail: BehaviorRelay<Bool> { get }
}

protocol CreateShopViewModelOutputs {
    var canCreate: BehaviorRelay<Bool> { get }
    var prepareEmail: BehaviorRelay<Bool> { get }
    var showsKeyboard: BehaviorRelay<Bool> { get }
}

protocol CreateShopViewModelType {
    var input: CreateShopViewModelInputs { get }
    var output: CreateShopViewModelOutputs { get }
}

class CreateShopViewModel: CreateShopViewModelType, CreateShopViewModelInputs, CreateShopViewModelOutputs {
    var input: CreateShopViewModelInputs {
        return self
    }
    var output: CreateShopViewModelOutputs {
        return self
    }
    let canCreate: BehaviorRelay<Bool> = .init(value: false)
    let prepareEmail: BehaviorRelay<Bool> = .init(value: false)
    let showsKeyboard: BehaviorRelay<Bool> = .init(value: false)

    let name: BehaviorRelay<String> = .init(value: "")
    let description: BehaviorRelay<String> = .init(value: "")
    let email: BehaviorRelay<String> = .init(value: "")
    let isCurrentEmail: BehaviorRelay<Bool> = .init(value: false)

    private let disposeBag = DisposeBag()

    init() {
        let validationName = name.asObservable().map { $0.count > 5 && $0.count < 15 }
        let validationEmail = Observable.zip(
            email.asObservable().map { $0.isEmail },
            isCurrentEmail.asObservable()
            )
            .map { $0.0 || $0.1 }

        Observable.zip(
            validationName,
            validationEmail
            )
            .map { $0.0 || $0.1 }
            .bind(to: canCreate)
            .disposed(by: disposeBag)

        Observable.merge(
            email.asObservable().map { _ in },
            isCurrentEmail.asObservable().map { _ in }
            )
            .map { [weak self] in
                guard let self = self else { return false }
                return self.email.value.isEmail || self.isCurrentEmail.value
            }
            .bind(to: prepareEmail)
            .disposed(by: disposeBag)

        Observable.merge(
            NotificationCenter.default.rx.notification(UIApplication.keyboardWillShowNotification).map { _ in true },
            NotificationCenter.default.rx.notification(UIApplication.keyboardWillHideNotification).map { _ in false }
            )
            .bind(to: showsKeyboard)
            .disposed(by: disposeBag)
    }
}

extension String {
    fileprivate var isEmail: Bool {
        let val = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", val).evaluate(with: self)
    }
}
