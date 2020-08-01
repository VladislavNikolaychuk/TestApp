//
//  ProductConfigurator.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductConfigurator {
    
    static func create(product: Product) -> UIViewController {
        let productController = ProductViewController()
        let presenter: ProductPresenterProtocol & ProductInteractorOutputProtocol = ProductPresenter(product: product)
        productController.presenter = presenter
        presenter.view = productController
        let interactor: ProductInteractorInputProtocol = ProductInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        return productController
    }
}
