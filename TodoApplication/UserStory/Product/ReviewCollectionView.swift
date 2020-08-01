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
        let width = (UIScreen.main.bounds.width - 32.0)
        let height = (width / 161) * 70
        return CGSize(width: width, height: height)
    }
}

