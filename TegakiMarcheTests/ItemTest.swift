// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarcheTests.
// CreatedAt: 17:08.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

@testable import TegakiMarche
import XCTest
import FirebaseFirestore

class FirebaseItemTests: XCTestCase {
    func testShouldInitialize() {
        let json: [String: Any] = ["title":"ttt",
                                   "desc":"ddd",
                                   "publishedAt": Timestamp(date: Date.create(yyyyMMdd: "20170810")!),
                                   "isPublished": true,
                                   "type":"pickup"]
        do {
            let item = try Firebase.Item(id: "xxx", timestamps: Timestamps(createdAt: Date(), updatedAt: Date()), json: json)
            XCTAssertTrue(item.publishedAt<Date())
            XCTAssertTrue(item.isPublished)
            XCTAssertTrue(item.type == .pickup)
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
}

extension Date {
    static func create(yyyyMMdd text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMddHHmmssZ"
        return formatter.date(from: text+"000000+09:00")
    }
}
