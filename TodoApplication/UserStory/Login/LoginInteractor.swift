//
//  LoginInteractor.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginInteractor: LoginInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var presenter: LoginInteractorOutputProtocol?
    
    func loginWith(userName: String, password: String) {
        Auth.auth().signIn(withEmail: userName, password: password) { (result, error) in
            if let result = result {
                self.presenter?.loginProccessSuccess()
            } else {
                self.presenter?.loginProccessFail(Text.smthWentWrong.localized)
            }
        }
    }
}
