//
//  ProductsInteractor.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 28.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class ProductsInteractor: ProductsInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    var presenter: ProductsInteractorOutputProtocol?
    
    func fetchProducts() {
        let request = ProductsEndpoint.getProducts
        networkManager.fetch(endPoint: request, responseType: [Product].self) { (result, error) in
            if let result = result {
                self.presenter?.fetchProductList(result)
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.fetchProductListFail(error)
            }
        }
    }
}
