//
//  NetworkManager.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    var globalHeaders: HTTPHeaders? {
        let token = AuthManager.shared.token()
        var options: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        if token != "" {
            options["Authorization"] = "token \(token)"
        }
        return options
    }
        
    private func handleResponse<T: Decodable>(result: Result<String>,
                                              responseData: Data,
                                              responseType: T.Type,
                                              completion: @escaping (
        _ apiResponse: T?,
        _ error: String?) -> Void) {
        switch result {
        case .success:
            do {
                let apiResponse = try JSONDecoder().decode(responseType, from: responseData)
                completion(apiResponse, nil)
            } catch {
                 do {
                    let failResponse = try JSONDecoder().decode(DefaultFailResponse.self, from: responseData)
                     completion(nil, failResponse.message)
                 } catch {
                      completion(nil, NetworkResponse.unableToDecode.error())
                 }
            }
        case .failure(let networkFailureError):
            completion(nil, networkFailureError.description)
        }
    }
    
    func fetch<T: Decodable, APIEndPoint: EndPointType>(endPoint: APIEndPoint,
                                                        responseType: T.Type,
                                                        completion: @escaping (
        _ apiResponse: T?, _ error: String?) -> Void) {
        guard let url = endPoint.requestPath else {
            completion(nil, Text.smthWentWrong.localized)
            return
        }
        print("globalHeaders \(globalHeaders) \(url) \(endPoint.httpMethod)")
        AF.request(url,
                   method: endPoint.httpMethod,
                   parameters: endPoint.options ?? [:],
                   encoding: endPoint.encoding,
                   headers: globalHeaders)
            .validate()
            .responseJSON { output in
                if let response = output.response,
                    let responseData = output.data {
                    let result = NetworkSettingsManager.handleNetworkResponse(response)
                    self.handleResponse(result: result,
                                        responseData: responseData,
                                        responseType: responseType) { (responseType, error) in
                                            completion(responseType, error)
                    }
                } else {
                    completion(nil, Text.smthWentWrong.localized)
                }
            }
    }
}
