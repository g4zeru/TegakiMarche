//
//  Item.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/08.
//

import Ballcap

extension FirebaseDatastore {
    final class Item: Object {
        dynamic var title: String = .init()
        dynamic var description: String = .init()
        dynamic var price: Int = .init()
        dynamic var rate: Double = .init()
        dynamic var imagePath: String = .init()
    }
}
