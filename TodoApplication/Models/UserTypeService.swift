//
//  UserTypeService.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 31.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

enum UserType {
    case anonymus, authorized
}

class UserTypeService {
    
    var type: UserType = .anonymus
    
    static let shared = UserTypeService()
    private init () {}
    
}
