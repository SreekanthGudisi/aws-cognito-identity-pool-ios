//
//  ErrorMessage.swift
//  DieselApp
//
//  Created by Gudisi, Manjunath on 07/06/18.
//  Copyright © 2018 Narayan. All rights reserved.
//

import Foundation

struct ErrorMessage : Codable {
    
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    
}
