// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 19:23.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import Instantiate

class DetailTextView: UIView, NibInstantiatable {
    typealias Dependency = String
    @IBOutlet private weak var textLabel: UILabel!
    func inject(_ dependency: String) {
        textLabel.text = dependency
    }
}
