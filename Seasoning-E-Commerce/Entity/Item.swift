//
//  Item.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/08.
//

import Ballcap
import FirebaseStorage

extension FirebaseDatastore {
    final class Item: Modelable, Codable {
        dynamic var title: String = ""
        dynamic var desc: String = ""
        ///default value
        dynamic var price: Int = 500
        dynamic var isPublished: Bool = true
        dynamic var publishedAt: Date = Date()
        dynamic var imagePath: String = ""
    }
}

extension FirebaseDatastore.Item {
    var storageImageRef: StorageReference {
        return Storage.storage().reference().child(imagePath)
    }
}

extension FirebaseDatastore.Item: FirebaseDatastoreQuery {
    static var baseQuery: DataSource<Document<FirebaseDatastore.Item>>.Query {
        return Document<FirebaseDatastore.Item>.query
    }
}
