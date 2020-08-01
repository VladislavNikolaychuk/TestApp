//
//  SignUpProtocols.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

protocol SignUpViewProtocol: class {

    var presenter: SignUpPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAlert(with message: String)
    func invalidateUserField()
    func invalidatePasswordField()
}

protocol SignUpPresenterProtocol: class {
    
    var view: SignUpViewProtocol? { get set }
    var interactor: SignUpInteractorInputProtocol? { get set }
    var router: SignUpRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func signUpWith(userName: String, password: String)
    func navigateToLoginViewController()
}

protocol SignUpInteractorInputProtocol: class {
    
    var presenter: SignUpInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func signUpWith(userName: String, password: String)
}

protocol SignUpInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func signUpProccessSuccess()
    func signUpProccessFail(_ error: String)
}

protocol SignUpRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToLoginViewController(from view: SignUpViewProtocol)
    func navigateToMainApp()
}

