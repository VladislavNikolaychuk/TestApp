//
//  NetworkResponse.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case serviceUnaccessible = "Service is unaccessible"
    func error() -> String {
        return self.rawValue
    }
}
