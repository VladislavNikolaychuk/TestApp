//
//  Localizable.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 27.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

enum Text: String, Localizable {
    
    case done
    case userName
    case password
    case login
    case signUp
    case go
    case toSignUpFlow
    case userNameInvalid
    case passwordInvalid
    case smthWentWrong
    case invalidEmail
    case todos
    case deadline
    case sort
    case todosTitle
    case settingsTitle
    case delete
    case edit
    case createTitle
    case editTitle
    case success
    case invalidMessage
    case Logout
    case Sorting
    case Saved
    case editSortingTitle
    case products
    case goToLogin
    case cancel
    case doYouWantMessage
    case alertDescription
    case send
    case typeHere
    case commentSent
    case invalidateCommentField
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}
