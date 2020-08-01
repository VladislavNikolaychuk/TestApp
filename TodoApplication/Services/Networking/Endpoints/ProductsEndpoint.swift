//
//  ProductsEndpoint.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 31.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import Alamofire

enum ProductsEndpoint {
    case getProducts
    case getReviews(ID: Int)
    case sendComment(productID: Int, rate: Int, comment: String)
}

extension ProductsEndpoint: EndPointType {
    
    var baseURL: URL? {
        return URL(string: environmentBaseURL)
    }
    
    
    var path: String {
        switch self {
        case .getProducts:
            return "products/"
        case .getReviews(let ID):
            return "reviews/\(ID)"
        case .sendComment(let productID, _, _):
            return "reviews/\(productID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        case .getReviews:
            return .get
        case .sendComment:
            return .post
        }
    }
    
    //swiftlint:disable pattern_matching_keywords
    var options: [String: Any]? {
        switch self {
        case .sendComment(_, let rate, let comment):
            let options: [String: Any] = [
                "rate": rate,
                "text": comment
            ]
            return options
        case .getProducts:
            return nil
        case .getReviews:
            return nil
        }
    }
        
    var encoding: ParameterEncoding {
        switch self {
        case .getProducts:
            return URLEncoding.default
        case .getReviews:
            return URLEncoding.default
        case .sendComment:
            return JSONEncoding.default
        }
    }
    //swiftlint:enable pattern_matching_keywords
}
