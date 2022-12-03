//
//  CreateToken.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation

struct CreateTokenResponse: Codable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
    let statusCode: Int?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
}
