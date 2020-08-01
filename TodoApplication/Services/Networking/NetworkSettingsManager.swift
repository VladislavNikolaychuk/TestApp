//
//  NetworkSettingsManager.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class NetworkSettingsManager {
    
    private static var sharedNetworkManager: NetworkSettingsManager = {
        let networkManager = NetworkSettingsManager()
        return networkManager
    }()
    
    private init() {}
    
    class func shared() -> NetworkSettingsManager {
        return sharedNetworkManager
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 422:
            return .success
        case 400...500:
            return .failure(NetworkResponse.serviceUnaccessible.error())
        case 501...599:
            return .failure(NetworkResponse.serviceUnaccessible.error())
        case 600:
            return .failure(NetworkResponse.outdated.error())
        default:
            return .failure(NetworkResponse.failed.error())
        }
    }
    
}
