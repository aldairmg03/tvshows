//
//  Authentication.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation

struct Authentication: Codable {
    let username: String
    let password: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
    
}
