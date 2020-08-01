//
//  SignUpViewController.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import MBProgressHUD

class SignUpViewController: BaseController {
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var loginField: TDField!
    @IBOutlet weak var passwordField: TDField!
    var presenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.signUp.localized
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        showLoader()
        presenter?.signUpWith(userName: loginField.text ?? "",
                             password: passwordField.text ?? "")
    }
    
    @IBAction func editingDidBegin(_ sender: Any) {
        loginField.setToValid()
        passwordField.setToValid()
        alert.text = ""
    }
    
}
extension SignUpViewController: SignUpViewProtocol {
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
