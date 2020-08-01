//
//  Review.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 30.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class Review : Codable {
    var id: Int
    var product: Int
    var userData: UserData
    var rate: Int
    var text: String
    var createdDate: String
    
    enum ResultCodingKeys: String, CodingKey {
        case id
        case product
        case userData = "created_by"
        case rate
        case text
        case createdDate = "created_at"
    }
    required init(from decoder: Decoder) throws {
        let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
        id = try objectsContainer.decode(Int.self, forKey: .id)
        product = try objectsContainer.decode(Int.self, forKey: .product)
        userData = try objectsContainer.decode(UserData.self, forKey: .userData)
        rate = try objectsContainer.decode(Int.self, forKey: .rate)
        text = try objectsContainer.decode(String.self, forKey: .text)
        createdDate = try objectsContainer.decode(String.self, forKey: .createdDate)
    }
}
