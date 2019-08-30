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
    }
}
