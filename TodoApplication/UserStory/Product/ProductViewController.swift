//
//  ProductViewController.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import Cosmos

class ProductViewController: BaseController, ProductViewProtocol {
 
    @IBOutlet weak var heighRaitCNST: NSLayoutConstraint!
    var presenter: ProductPresenterProtocol?
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet private weak var alert: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet weak var mainReviwesView: UIView!
    @IBOutlet private weak var productDescription: UILabel!
    @IBOutlet weak var reviewCollectionView: ReviewCollectionView!
    @IBOutlet weak var rateView: UIView!
    
    private lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.settings.filledImage = UIImage(named:"star_full")?.withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named:"empty_star")?.withRenderingMode(.alwaysOriginal)
        view.settings.updateOnTouch = true
        view.settings.starMargin = 8.0
        view.settings.starSize = 40
        view.settings.totalStars = 5
        view.settings.filledColor = Colors.blue
        view.settings.emptyColor = Colors.white
        view.settings.emptyBorderColor = UIColor.clear
        view.settings.filledBorderColor = UIColor.clear
        view.rating = 1.0
        return view
    }()
    
    func textViewType() {
        messageTextView.addCancelToolbar()
        messageTextView.placeholder = Text.typeHere.localized
        messageTextView.textContainerInset = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
    }
    
    func showAlert(with message: String) {
        hideLoader()
        alert.text = message
    }
    
    func showProduct(_ product: Product) {
        productName.text = product.title
        productDescription.text = product.text
        productImage.setupImage(imageName: product.image)
    }
    
    func showReviewsList(_ list: [Review]) {
        hideLoader()
        reviewCollectionView.reviews = list
        reviewCollectionView.reloadData()
    }
    
    func hideMainRaitBlock() {
        guard let presenter = presenter else { return }
        if !presenter.isRaviewsAvailable() {
            mainReviwesView.subviews.forEach { $0.removeFromSuperview() }
            heighRaitCNST.constant = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainRaitBlock()
        showLoader()
        textViewType()
        rateView.addSubview(cosmosView)
//        cosmosView.centerInSuperview()
        presenter?.viewDidLoad()
        navigationItem.title = productName.text
        reviewCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil),
                                      forCellWithReuseIdentifier: CellID.reviewCell.rawValue)
        reviewCollectionView.dataSource = reviewCollectionView
        reviewCollectionView.delegate = reviewCollectionView
        
    }
    
    @IBAction func sendCommentAction(_ sender: Any) {
        showLoader()
        presenter?.sendReview(rate: Int(cosmosView.rating), comment: messageTextView.text ?? "")
        cosmosView.rating = 1
        messageTextView.text = ""
    }
}
