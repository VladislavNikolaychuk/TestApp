//
//  ProductInteractor.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class ProductInteractor: ProductInteractorInputProtocol {

    private let networkManager = NetworkManager()
    var presenter: ProductInteractorOutputProtocol?
    
    func fetchReviews(ID: Int) {
        let request = ProductsEndpoint.getReviews(ID: ID)
        networkManager.fetch(endPoint: request, responseType: [Review].self) { (result, error) in
            if let result = result {
                self.presenter?.fetchReviewsList(result)
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.fetchReviewsListFail(error)
            }
        }
    }
    
    func sendReview(productID: Int, rate: Int, comment: String) {
        let request = ProductsEndpoint.sendComment(productID: productID, rate: rate, comment: comment)
        networkManager.fetch(endPoint: request, responseType: DefaultFailResponse.self) { (result, error) in
            if let result = result, result.success {
                self.presenter?.createReviewSuccesed()
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.createReviewFailed(error)
            }
        }
    }
    
}
