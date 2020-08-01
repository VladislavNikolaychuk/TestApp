//
//  LoginViewController.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

final class LoginViewController: BaseController {
    
    @IBOutlet weak var passwordField: TDField!
    @IBOutlet weak var loginField: TDField!
    @IBOutlet weak var alert: UILabel!
    var presenter: LoginPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.login.localized
    }
    
    @IBAction func showProductsAction(_ sender: Any) {
        presenter?.navigateToProductsViewController()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        showLoader()
        presenter?.loginWith(userName: loginField.text ?? "",
                             password: passwordField.text ?? "")
    }
    
    @IBAction func signUpAction(_ sender: Any) {
         presenter?.navigateToSignUpViewController()
    }
    
    @IBAction func editingDidBegin(_ sender: Any) {
        loginField.setToValid()
        passwordField.setToValid()
        alert.text = ""
    }
    
}

extension LoginViewController: LoginViewProtocol {
    
    func showAlert(with message: String) {
        hideLoader()
        alert.text = message
    }
    
    func invalidateUserField() {
        loginField.setToInvalid()
    }
    
    func invalidatePasswordField() {
        passwordField.setToInvalid()
    }
    
}
