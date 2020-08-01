//
//  LoginConfigurator.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class LoginConfigurator {
    
    static func createLoginRouterModule() -> UIViewController {
        let loginController = LoginViewController()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        loginController.presenter = presenter
        presenter.view = loginController
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: LoginRouterProtocol = LoginRouter()
        presenter.router = router
        return loginController
    }

}
