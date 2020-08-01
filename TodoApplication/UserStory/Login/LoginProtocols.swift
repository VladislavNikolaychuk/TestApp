//
//  LoginProtocols.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {

    var presenter: LoginPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAlert(with message: String)
    func invalidateUserField()
    func invalidatePasswordField()
}

protocol LoginPresenterProtocol: class {
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func loginWith(userName: String, password: String)
    func navigateToSignUpViewController()
    func navigateToProductsViewController()
}

protocol LoginInteractorInputProtocol: class {
    
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loginWith(userName: String, password: String)
}

protocol LoginInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func loginProccessSuccess()
    func loginProccessFail(_ error: String)
}

protocol LoginRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToSignUpViewController(from view: LoginViewProtocol)
    func navigateToMainApp()
    func navigateToProductController(from view: LoginViewProtocol)
}
