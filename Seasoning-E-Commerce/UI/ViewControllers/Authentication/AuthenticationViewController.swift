//
//  AuthenticationViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/20.
//

import UIKit
import Firebase
import GoogleSignIn
import SnapKit
import RxSwift
import RxCocoa

class AuthenticationViewController: UIViewController, GIDSignInUIDelegate {
    var authStateListener: AuthStateDidChangeListenerHandle?
    let viewModel: AuthenticationViewModelType = AuthenticationViewModel()
    private let loadingView: LoadingOvelayView = LoadingOvelayView()
    let disposeBag = DisposeBag()
    private let signInWithGoogleButton = GIDSignInButton()
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(signInWithGoogleButton)
        self.view.addSubview(loadingView)
        signInWithGoogleButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(200)
        }
        loadingView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        loadingView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user {
                self?.viewModel.inputs.createUser(authedUser: user)
            }
        }
        viewModel.outputs
            .customer
            .subscribe(onNext: { [weak self] (_) in
                self?.loadingView.stop()
                self?.loadingView.isHidden = true
                if let nav = self?.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(authStateListener!)
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        self.loadingView.isHidden = false
        self.loadingView.start()
    }
}
