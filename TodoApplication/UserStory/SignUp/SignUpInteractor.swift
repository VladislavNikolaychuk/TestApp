//
//  SignUpInteractor.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class SignUpInteractor: SignUpInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var presenter: SignUpInteractorOutputProtocol?
    
    func signUpWith(userName: String, password: String) {
        let request = AuthEndpoint.signUp(username: userName, password: password)
        networkManager.fetch(endPoint: request, responseType: AuthResponse.self) { (result, error) in
            if let authCredentials = result,
                AuthManager.shared.saveCredentials(authCredentials.token) {
                self.presenter?.signUpProccessSuccess()
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.signUpProccessFail(error)
            }
            
        }
        
    }
    
}
