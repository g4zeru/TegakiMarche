//
//  User.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/07.
//

import Foundation
import Ballcap

extension FirebaseDatastore {
    @objcMembers
    final class Customer: Codable, Modelable {
        dynamic var uid: String = .init()
        dynamic var name: String = .init()
    }
}
