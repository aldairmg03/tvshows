//
//  LoginUseCase.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class LoginUseCase: LoginUseCaseProtocol {
    
    private let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    func createRequestToken() -> AnyPublisher<CreateTokenResponse, ApiError> {
        return self.repository.createRequestToken()
    }
    
    func authentication(auth: Authentication) -> AnyPublisher<CreateTokenResponse, ApiError> {
        return self.repository.authentication(auth: auth)
    }
    
}
