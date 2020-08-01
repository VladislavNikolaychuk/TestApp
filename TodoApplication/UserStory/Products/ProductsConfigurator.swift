//
//  ProductsConfigurator.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductsConfigurator {
    
    static func create() -> UIViewController {
        let productsController = ProductsViewController()
        let presenter: ProductsPresenterProtocol & ProductsInteractorOutputProtocol = ProductsPresenter()
        let router: ProductsRouterProtocol = ProductsRouter()
        presenter.router = router
        productsController.presenter = presenter
        presenter.view = productsController
        let interactor: ProductsInteractorInputProtocol = ProductsInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        return productsController
    }
}
