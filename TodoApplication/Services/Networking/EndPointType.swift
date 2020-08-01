//
//  EndPointType.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var options: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

extension EndPointType {
    
    var environmentBaseURL: String {
        return Configurations.get().baseURL
    }
    
    var requestPath: URL? {
        guard let requestPath = self.baseURL?.appendingPathComponent(path) else {
            return nil
        }
        return requestPath
    }
        
}
