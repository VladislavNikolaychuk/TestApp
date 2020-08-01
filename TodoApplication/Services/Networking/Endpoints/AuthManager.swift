//
//  AuthManager.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 24.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation
import SimpleKeychain

final class AuthManager {
    
    static let shared = AuthManager()
    
    var isAuthorized: Bool {
        return A0SimpleKeychain().string(forKey: AuthKeys.token.rawValue) != nil
    }
    
    enum AuthKeys: String {
        case token = "auth_token"
    }
    
    private init() {}
    
    internal func clearAuthCredentials() {
        _ = A0SimpleKeychain().deleteEntry(forKey: AuthKeys.token.rawValue)
    }
    
    func saveCredentials(_ token: String) -> Bool {
        let isTokenSet = A0SimpleKeychain().setString(token,
                                                      forKey: AuthKeys.token.rawValue)
        return isTokenSet
    }
    
    func logout() {
        clearAuthCredentials()
    }
    
    func token() -> String {
        return A0SimpleKeychain().string(forKey: AuthKeys.token.rawValue) ?? ""
    }
    
}
