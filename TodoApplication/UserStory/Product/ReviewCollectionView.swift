//
//  ReviewCollectionView.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 30.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

class ReviewCollectionView: UICollectionView {
    var reviews: [Review] = []
}

extension ReviewCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func numberOfSections (in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.reviewCell.rawValue, for: indexPath) as? ReviewCell {
            let review = reviews[indexPath.row]
            itemCell.setReviewData(review: review)
            return itemCell
        }
        return UICollectionViewCell()
    }
}

extension ReviewCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = Bundle.main.loadNibNamed(String(describing: ReviewCell.self),
            owner: self, options: nil)?.first as? ReviewCell else { return CGSize.zero }
        let review = reviews[indexPath.row]
        cell.setReviewData(review: review)
        return getAutomaticHeight(cell: cell)
    }
    
    func getAutomaticHeight(cell: UICollectionViewCell?) -> CGSize {
        guard let cell = cell else {
            return CGSize.zero
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let width = UIScreen.main.bounds.width - 48.0
        let targetSize = CGSize(width: width, height: 0)
        let size = cell.contentView.systemLayoutSizeFitting(targetSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .fittingSizeLevel)
        return size
    }
}

