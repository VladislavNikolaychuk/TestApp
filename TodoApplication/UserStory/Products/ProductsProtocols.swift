//
//  ProductsProtocols.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

protocol ProductsViewProtocol: class {

    var presenter: ProductsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAlert(with message: String)
    func showProductsList(_ list: [Product])
    func setToAnonymusMode()
    func setToAuthorizedMode()
    func setLogoutImage()
    func setLoginImage()
}


protocol ProductsPresenterProtocol: class {
    
    var view: ProductsViewProtocol? { get set }
    var interactor: ProductsInteractorInputProtocol? { get set }
    var router: ProductsRouterProtocol? { get set }
    var products: [Product] { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func navigateToProductPreview(product: Product)
    func tappedLoginLogoutButton()
}

protocol ProductsInteractorInputProtocol: class {
    
    var presenter: ProductsInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchProducts()
}

protocol ProductsInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func fetchProductList(_ list: [Product])
    func fetchProductListFail(_ message: String)
}

protocol ProductsRouterProtocol: class {

    // PRESENTER -> ROUTER
    func openProductModule(from view: ProductsViewProtocol, product: Product)
}
