// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:13.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate
import InstantiateStandard

class ColumnContentCell: HomeContentCell, Reusable, NibType, NibInstantiatable {
    typealias Dependency = Firebase.PickupItem
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func inject(_ dependency: Firebase.PickupItem) {
        return
    }
}
