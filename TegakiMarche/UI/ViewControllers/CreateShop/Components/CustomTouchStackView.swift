//
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 2:02.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import RxRelay
import RxSwift
import UIKit

class CustomTouchStackView: UIStackView {
    var touches: Observable<(Set<UITouch>, UIEvent?)> {
        return touchSubject
    }
    private let touchSubject = PublishSubject<(Set<UITouch>, UIEvent?)>()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchSubject.onNext((touches, event))
    }
}
