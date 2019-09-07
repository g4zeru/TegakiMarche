//
//  Auth.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/20.
//

import FirebaseAuth
import Foundation
import GoogleSignIn

class AuthenticationController: NSObject, GIDSignInDelegate {
    weak var delegate: FirebaseAuthencationDelegate?
    static let sharedInstance = AuthenticationController()

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.delegate?.error(case: .signIn(error))
            return
        }
        guard let authentication = user.authentication else { return }
        let credencial = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credencial, completion: resultCallback())
    }

    private func resultCallback() -> AuthDataResultCallback {
        return { [weak self] result, error in
            if let error = error {
                self?.delegate?.error(case: .signIn(error))
            }
            self?.delegate?.finished()
        }
    }
}

enum FirebaseAuthencationError {
    case signIn(Error)
}

protocol FirebaseAuthencationDelegate: AnyObject {
    func finished()
    func error(case: FirebaseAuthencationError)
}
