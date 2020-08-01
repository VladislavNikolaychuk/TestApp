//
//  ProductsPresenter.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductsPresenter: ProductsPresenterProtocol {
    
    var view: ProductsViewProtocol?
    var interactor: ProductsInteractorInputProtocol?
    var router: ProductsRouterProtocol?
    var products: [Product] = []
    
    func viewDidLoad() {
        if UserTypeService.shared.type == .authorized {
            view?.setLogoutImage()
        } else if UserTypeService.shared.type == .anonymus {
            view?.setLoginImage()
        }
        interactor?.fetchProducts()
    }
    
    func tappedLoginLogoutButton() {
        if UserTypeService.shared.type == .authorized {
            view?.setToAuthorizedMode()
        } else if UserTypeService.shared.type == .anonymus {
            view?.setToAnonymusMode()
        }
    }
    
    func navigateToProductPreview(product: Product) {
        
        guard let view = view else { return }
        router?.openProductModule(from: view, product: product)
    }
}

extension ProductsPresenter: ProductsInteractorOutputProtocol {
    
    func fetchProductList(_ list: [Product]) {
        self.products = list
        view?.showProductsList(list)
    }
    
    func fetchProductListFail(_ message: String) {
        view?.showAlert(with: message)
    }
}
