// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 2:58.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import Foundation
import Firebase
import Ballcap
import RxSwift

protocol AuthenticationViewModelInputs {
    func createUser(authedUser: User)
}

protocol AuthenticationViewModelOutputs {
    var customer: Observable<FirebaseDatastore.Customer> { get }
}

protocol AuthenticationViewModelType {
    var inputs: AuthenticationViewModelInputs { get }
    var outputs: AuthenticationViewModelOutputs { get }
}

class AuthenticationViewModel: AuthenticationViewModelType, AuthenticationViewModelInputs, AuthenticationViewModelOutputs {
    
    var customer: Observable<FirebaseDatastore.Customer> {
        return customerSubject
    }
    
    let customerSubject = PublishSubject<FirebaseDatastore.Customer>()
    
    var inputs: AuthenticationViewModelInputs {
        return self
    }
    
    var outputs: AuthenticationViewModelOutputs {
        return self
    }
    
    var userDoc: Document<FirebaseDatastore.Customer> = Document()
    
    func createUser(authedUser: User) {
        userDoc.data = {
            let user = FirebaseDatastore.Customer()
            user.name = authedUser.displayName ?? authedUser.uid
            user.uid = authedUser.uid
            return user
        }()
        userDoc.save(reference: FirebaseDatastore.standardDatastore.collection("users").document(authedUser.uid)) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.customerSubject.onError(error)
            } else {
                self.customerSubject.onNext(self.userDoc.data!)
            }
        }
    }
}
