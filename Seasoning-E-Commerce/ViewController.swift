//
//  ViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit
import FirebaseAuth
import Ballcap

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
    }
    var datasource: DataSource<Document<FirebaseDatastore.User>>?
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
