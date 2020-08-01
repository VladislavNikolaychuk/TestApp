//
//  SignUpConfigurator.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class SignUpConfigurator {
    
    static func createSignUpRouterModule() -> UIViewController {
        let signUpController = SignUpViewController()
        let presenter: SignUpPresenterProtocol & SignUpInteractorOutputProtocol = SignUpPresenter()
        signUpController.presenter = presenter
        presenter.view = signUpController
        let interactor: SignUpInteractorInputProtocol = SignUpInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: SignUpRouterProtocol = SignUpRouter()
        presenter.router = router
        return signUpController
    }

}
