//
//  ProductsRouter.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductsRouter: ProductsRouterProtocol {
    
    func controller(view: ProductsViewProtocol) -> UIViewController? {
        return view as? UIViewController
    }
    
    func openProductModule(from view: ProductsViewProtocol, product: Product) {
        let module = ProductConfigurator.create(product: product)
        controller(view: view)?.navigationController?.pushViewController(module, animated: true)
    }
    
}
