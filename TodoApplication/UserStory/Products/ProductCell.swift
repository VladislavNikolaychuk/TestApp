//
//  ProductCell.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var goToSinglePageAction: (() -> Void)?
            
    func setProductData(product: Product) {
        descriptionLabel.text = product.text
        titleLabel.text = product.title
        mainView.layer.cornerRadius = 8.0
        mainView.layer.borderWidth = 1.0
        imageView.setupImage(imageName: product.image)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(choosedProduct))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    @objc func choosedProduct() {
        self.goToSinglePageAction?()
    }
}
