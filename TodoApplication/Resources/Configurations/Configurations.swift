//
//  Configuration.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 24.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import Foundation

struct Configurations {
   
    struct Config: Decodable {
        let baseURL: String
    }
    
    static func get() -> Config {
        
        let path = Bundle.main.url(forResource: "Configurations", withExtension: "plist")
        
        guard let url = path else {
            fatalError("Could not find Configuration.plist in you Bundle")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(Config.self, from: data)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
    }
}
