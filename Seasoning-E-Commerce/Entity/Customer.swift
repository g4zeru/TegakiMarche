//
//  User.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/07.
//

import Foundation
import FirebaseFirestore
import Ballcap

extension FirebaseDatastore {
    @objcMembers
    final class User: Decodable, Modelable {
        dynamic var name: String = .init()
        dynamic var isBanned: Bool = false
        dynamic var email: String? = nil
        dynamic var profileImagePath: String = .init()
    }
}
extension FirebaseDatastore.User: FirebaseDatastoreQuery {
    static var baseQuery: DataSource<Document<FirebaseDatastore.User>>.Query {
        return Document<FirebaseDatastore.User>
            .where("isBanned", isEqualTo: false)
            .order(by: "updatedAt", descending: true)
    }
}
