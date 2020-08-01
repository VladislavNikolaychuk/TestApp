//
//  UserData.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 30.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class UserData: Codable {

    var id: Int
    var username: String
    
    enum ResultCodingKeys: String, CodingKey {
        case id
        case username
    }
    
    required init(from decoder: Decoder) throws {
         let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
         id = try objectsContainer.decode(Int.self, forKey: .id)
         username = try objectsContainer.decode(String.self, forKey: .username)
    }
}
