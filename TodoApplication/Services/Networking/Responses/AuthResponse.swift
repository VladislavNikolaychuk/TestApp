//
//  AuthResponse.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class AuthResponse: Decodable {
    let success: Bool
    let token: String
}

class DefaultFailResponse: Decodable {
    let success: Bool
    let message: String?
}
