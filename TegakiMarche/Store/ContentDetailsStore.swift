// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 22:12.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import RxSwift
import RxCocoa
import FirebaseFirestore

enum ComponentType {
    case content
    case mock
}

protocol ContentDetailsStore {
    var loading: Driver<Bool> { get }
}
