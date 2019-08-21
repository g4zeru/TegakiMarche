//
//  AuthenticationViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/20.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthenticationViewController: UIViewController, GIDSignInUIDelegate {
    var authStateListener: AuthStateDidChangeListenerHandle?
    private let signInWithGoogleButton = GIDSignInButton()
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
        self.view.addSubview(signInWithGoogleButton)
        signInWithGoogleButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(200)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                if let nav = self?.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(authStateListener!)
    }
}
