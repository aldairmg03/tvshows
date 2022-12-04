//
//  LoginRepository.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class LoginRepository: LoginRepositoryProtocol {
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func createRequestToken() -> AnyPublisher<CreateTokenResponse, ApiError> {
        return apiManager.request(.get, with: makeComponets(withEndpoint: TheMovieDBAPI.requesttoken), data: nil)
    }
    
    func authentication(auth: Authentication) -> AnyPublisher<CreateTokenResponse, ApiError> {
        let jsonData = try? JSONEncoder().encode(auth)
        return apiManager.request(.post, with: makeComponets(withEndpoint: TheMovieDBAPI.auth), data: jsonData)
    }
    
}
