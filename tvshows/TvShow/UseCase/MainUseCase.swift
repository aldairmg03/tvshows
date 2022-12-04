//
//  MainUseCase.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class MainUseCase: MainUseCaseProtocol {
    
    private let repository: MainRepositoryProtocol
    
    init(repository: MainRepositoryProtocol) {
        self.repository = repository
    }
    
    func tvShowFetch(forCategory category: String) -> AnyPublisher<TvShowsResponse, ApiError> {
        return repository.tvShowFetch(forCategory: category)
    }
    
    
}
