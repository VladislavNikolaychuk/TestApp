//
//  UIImageView+Extensions.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 30.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit
import Kingfisher

enum ImagePlaceholderType {
    case none
}
extension UIImageView {
    
    private func getImagePlaceholderByType(imageType: ImagePlaceholderType?) -> UIImage? {
        var image: UIImage?
        if let imageType = imageType {
            switch imageType {
            default:
                image = nil
            }
        }
        return image
    }
    
}
extension UIImageView {
    
    func setupImage(imageName: String?,
                    imageType: ImagePlaceholderType? = nil,
                    cornerRadius: CGFloat = 0,
                    completionHandler: ((UIImage?) -> Void)? = nil) {
        guard let image = imageName else {
            self.image = self.getImagePlaceholderByType(imageType: imageType)
            return
        }
        let imageName = "http://smktesting.herokuapp.com/static/\(image)"
        if ImageCache.default.isCached(forKey: imageName) {
            setImageIfCached(cacheKey: imageName, completionHandler: completionHandler)
        } else {
            self.loadImage(imageName: imageName, imageType: imageType, completion: completionHandler ?? { _ in })
        }
    }
    
    private func setImageIfCached(cacheKey: String, completionHandler: ((UIImage?) -> Void)? = nil) {
        ImageCache.default.retrieveImage(forKey: cacheKey) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completionHandler?(value.image)
                    self.image = value.image
                case .failure:
                    completionHandler?(nil)
                    self.image = nil
                }
            }
        }
    }
    
    private func loadImage(imageName: String,
                           imageType: ImagePlaceholderType?,
                           completion: @escaping ((UIImage?) -> Void)) {
        var url: URL?
        if let urlPath = URL(string: imageName) {
            url = urlPath
        } else if let stringUrlFixed = imageName
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let urlPath = URL(string: stringUrlFixed) {
            url = urlPath
        }
        guard let preparedUrl = url else {
            completion(nil)
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: preparedUrl,
            placeholder: self.getImagePlaceholderByType(imageType: imageType),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage,
                .forceRefresh
        ], completionHandler: { result in
            switch result {
            case .success(let imageObject):
                completion(imageObject.image)
            case .failure:
                completion(nil)
            }
        })
    }
}
