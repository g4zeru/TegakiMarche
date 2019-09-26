// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:58.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation

class ContentDetailsViewBuilder {
    static func audio() -> AudioControlView {
        let view = AudioControlView.instantiate()
        view.snp.makeConstraints { (maker) in
            maker.height.equalTo(200)
        }
        return view
    }
}
