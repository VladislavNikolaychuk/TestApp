//
//  ReviewCell.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 30.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    
    func setReviewData(review: Review) {
        mainView.layer.cornerRadius = 8.0
        mainView.layer.borderWidth = 1.0
        rate.text = "\(review.rate)"
        authorName.text = review.userData.username
        comment.text = review.text
        createdDate.text = review.createdDate
    }
}


