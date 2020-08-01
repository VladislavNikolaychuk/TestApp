//
//  ProductPresenter.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ProductPresenter: ProductPresenterProtocol {
    
    var view: ProductViewProtocol?
    var interactor: ProductInteractorInputProtocol?
    var router: ProductRouterProtocol?
    var product: Product
    var reviews: [Review] = []
    
    init(product: Product) {
        self.product = product
    }
    
    func viewDidLoad() {
        view?.showProduct(product)
        interactor?.fetchReviews(ID: product.id)
    }
    
    func sendReview(rate: Int, comment: String) {
        guard comment != "" else {
            view?.hideLoader()
            return
        }
        interactor?.sendReview(productID: product.id, rate: rate, comment: comment)
    }
    
    func isRaviewsAvailable() -> Bool {
        return UserTypeService.shared.type == .authorized
    }
    
    func navigateToProductPreview() {
        guard let view = view else { return }
        router?.navigateToProductController(from: view)
    }
}

extension ProductPresenter: ProductInteractorOutputProtocol {
    
    func createReviewSuccesed() {
        interactor?.fetchReviews(ID: product.id)
        view?.showAlert(with: Text.commentSent.localized)
    }
    
    func createReviewFailed(_ message: String) {
        view?.showAlert(with: message)
    }
    
    func fetchReviewsList(_ list: [Review]) {
        self.reviews = list
        view?.showReviewsList(list)
    }
    
    func fetchReviewsListFail(_ message: String) {
        view?.showAlert(with: message)
    }
}

