//
//  SignUpInteractor.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import Firebase

class SignUpInteractor: SignUpInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var presenter: SignUpInteractorOutputProtocol?
    
    func signUpWith(userName: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: userName, password: password) { (result, error) in
            if let result = result {
                let ref = Database.database().reference().child("users")
                ref.child(result.user.uid).updateChildValues(["name" : name, "email": userName])
                self.presenter?.signUpProccessSuccess()
            } else {
                self.presenter?.signUpProccessFail(Text.smthWentWrong.localized)
            }
        }
    }
    
}
