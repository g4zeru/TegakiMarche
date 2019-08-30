//
//  ViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import Ballcap
import FirebaseAuth
import UIKit

class ViewController: UIViewController {
    var datasource: DataSource<Document<FirebaseDatastore.User>>?

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil {
            self.present(AuthenticationViewController(), animated: true, completion: nil)
        }
        Document<FirebaseDatastore.Item>.query
            .where("isPublished", isEqualTo: true)
            .order(by: "publishedAt", descending: true)
            .dataSource()
            .retrieve(from: { (snapshot, documentSnapshot, done) in
                let document: Document<FirebaseDatastore.Item> = Document(documentSnapshot.reference)
                document.get { (item, error) in
                    print(item)
                }
            })
            .get()
    }
}
