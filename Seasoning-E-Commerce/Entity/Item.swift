//
//  Item.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/07/08.
//

import Ballcap
import FirebaseStorage
import Firebase

extension FirebaseDatastore {
    final class Item: Modelable, Codable {
        dynamic var title: String = ""
        dynamic var desc: String = ""
        dynamic var price: Int = 0
        dynamic var isPublished: Bool = true
        dynamic var publishedAt: Timestamp = Timestamp()
        dynamic var imagePath: String? = ""
    }
}

extension Document where Model: FirebaseDatastore.Item {
    var storageOriginImageRef: StorageReference {
        return Storage.storage().reference().child("item").child(id).child("originImg")
    }
}

extension FirebaseDatastore.Item: FirebaseDatastoreQuery {
    static var baseQuery: DataSource<Document<FirebaseDatastore.Item>>.Query {
        return Document<FirebaseDatastore.Item>.query
    }
}
