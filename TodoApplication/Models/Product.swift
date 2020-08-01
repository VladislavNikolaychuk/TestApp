//
//  Product.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 29.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

class Product: Codable {
    var id: Int
    var image: String
    var text: String
    var title: String
    
    enum ResultCodingKeys: String, CodingKey {
        case id
        case image = "img"
        case text
        case title
    }
    
    required init(from decoder: Decoder) throws {
         let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
         id = try objectsContainer.decode(Int.self, forKey: .id)
         image = try objectsContainer.decode(String.self, forKey: .image)
         text = try objectsContainer.decode(String.self, forKey: .text)
         title = try objectsContainer.decode(String.self, forKey: .title)
    }
}
