//
//  MainRepository.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class  MainRepository: MainRepositoryProtocol {
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func tvShowFetch(forCategory category: String) -> AnyPublisher<TvShowsResponse, ApiError> {
        return apiManager.request(.get, with: makeComponets(withEndpoint: category), data: nil)
    }
    
}
