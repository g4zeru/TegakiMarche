//
//  AuthenticationViewController.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/20.
//

import Firebase
import GoogleSignIn
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class AuthenticationViewController: UIViewController {
    var authStateListener: AuthStateDidChangeListenerHandle?
    let disposeBag = DisposeBag()
    private let signInWithGoogleButton = GIDSignInButton()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(signInWithGoogleButton)
        signInWithGoogleButton.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalTo(200)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
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
        guard let listener = authStateListener else {
            return
        }
        Auth.auth().removeStateDidChangeListener(listener)
    }
}
