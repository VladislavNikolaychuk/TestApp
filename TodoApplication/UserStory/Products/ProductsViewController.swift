//
//  ProductsViewController.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductsViewController: BaseController, ProductsViewProtocol {
    
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var productsCollectionView: ProductCollectionView!
    @IBOutlet weak var logoutLogin: UIButton!
    var presenter: ProductsPresenterProtocol?
    
    func showAlert(with message: String) {
        hideLoader()
        alert.text = message
    }
    
    func showProductsList(_ list: [Product]) {
        hideLoader()
        productsCollectionView.products = list
        productsCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Text.products.localized
        showLoader()
        presenter?.viewDidLoad()
        productsCollectionView.register(UINib(nibName: "ProductCell", bundle: nil),
                                    forCellWithReuseIdentifier: CellID.productCell.rawValue)
        productsCollectionView.dataSource = productsCollectionView
        productsCollectionView.delegate = productsCollectionView
        productsCollectionView.productDidTap = { [weak self] product in
            self?.presenter?.navigateToProductPreview(product: product)
        }
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        presenter?.tappedLoginLogoutButton()
    }
    
    
    func setToAnonymusMode() {
        let alert = UIAlertController(title: Text.doYouWantMessage.localized, message: Text.alertDescription.localized,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Text.goToLogin.localized, style: UIAlertAction.Style.default,
                                      handler: { _ in
                                        AppRouter.runAuthFlow()
        }))
        alert.addAction(UIAlertAction(title: Text.cancel.localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setToAuthorizedMode() {
        AppRouter.runAuthFlow()
    }
    
    func setLogoutImage() {
        logoutLogin.setImage(UIImage(named:"logout_icon"), for: .normal)
        
    }
    
    func setLoginImage() {
        logoutLogin.setImage(UIImage(named: "login_icon"), for: .normal)
    }
    
}
