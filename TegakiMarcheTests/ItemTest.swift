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
                                   "imageURL":URL(string: "https://i-ogp.pximg.net/c/1050x550_80_a2_g2/img-master/img/2013/07/02/17/43/14/36786691_p0_master1200.jpg")!,
                                   "isPublished": true,
                                   "type":"pickup"]
        do {
            let item = try Firebase.PickupItem(id: "xxx", timestamps: Timestamps(createdAt: Date(), updatedAt: Date()), json: json)
            XCTAssertTrue(item.publishedAt<Date())
            XCTAssertTrue(item.isPublished)
            XCTAssertTrue(item.type == .pickup)
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
}
