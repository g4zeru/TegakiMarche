// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 13:45.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation

func developPrint(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}

func developDebugPrint(_ items: Any...) {
    #if DEBUG
    debugPrint(items)
    #endif
}
