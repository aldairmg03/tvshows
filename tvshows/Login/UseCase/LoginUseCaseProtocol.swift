//
//  LoginUseCaseProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

protocol LoginUseCaseProtocol: AnyObject {
    
    func createRequestToken() -> AnyPublisher<CreateTokenResponse, ApiError>
    
    func authentication(auth: Authentication) -> AnyPublisher<CreateTokenResponse, ApiError>
    
}
