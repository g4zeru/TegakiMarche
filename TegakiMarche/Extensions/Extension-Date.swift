// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 22:11.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation

extension Date {
    static func create(yyyyMMdd text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMddHHmmssZ"
        return formatter.date(from: text+"000000+09:00")
    }
}
