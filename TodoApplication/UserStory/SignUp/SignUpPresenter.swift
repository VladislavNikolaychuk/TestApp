//
//  SignUpPresenter.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class SignUpPresenter: SignUpPresenterProtocol {
    var router: SignUpRouterProtocol?
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInteractorInputProtocol?
    
    func signUpWith(userName: String, password: String) {
        let result = validateForm(userName: userName, password: password)
        if result.isValid {
            interactor?.signUpWith(userName: userName, password: password)
        } else {
            view?.showAlert(with: result.error ?? Text.smthWentWrong.localized)
        }
    }
    
    func navigateToLoginViewController() {
        guard let view = view else {
            return
        }
        router?.navigateToLoginViewController(from: view)
    }
    
    private func validateForm(userName: String, password: String) -> (isValid: Bool, error: String?) {
        var result: (isValid: Bool, error: String?) = (isValid: false, error: nil)
        let isUserValid = userName != ""
        let isPasswordValid = password != ""
        
        if !isUserValid {
            view?.invalidateUserField()
            result.error = Text.userNameInvalid.localized
        }
        if !isPasswordValid {
            view?.invalidatePasswordField()
            if isUserValid {
                result.error = Text.passwordInvalid.localized
            }
        }
        result.isValid = isUserValid && isPasswordValid
        return result
    }
    
}

extension SignUpPresenter: SignUpInteractorOutputProtocol {

    func signUpProccessSuccess() {
        router?.navigateToMainApp()
    }
    
    func signUpProccessFail(_ error: String) {
        view?.showAlert(with: error)
    }
    
}
