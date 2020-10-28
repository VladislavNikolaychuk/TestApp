//
//  LoginViewController.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

final class LoginViewController: BaseController {
    
    
    @IBOutlet weak var passwordField: TDField!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var loginField: TDField!
    @IBOutlet weak var alert: UILabel!
    var presenter: LoginPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        navigationItem.title = Text.login.localized
        
    }
    
    func loadLayout() {
        let googleSignIn = GIDSignInButton()
        buttonStack.addArrangedSubview(googleSignIn)
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

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                alert.text = Text.signGoogleError.localized
            } else {
                alert.text = "\(error.localizedDescription)"
            }
            return
        }
        
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credentials, completion: {(user, error) in
            if let err = error {
                self.alert.text = err.localizedDescription
                return
            }
            guard (user?.user.uid) != nil else {return}
        })
        AppRouter.runMainFlow()
    }
}
