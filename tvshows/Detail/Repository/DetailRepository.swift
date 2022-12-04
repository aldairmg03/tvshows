//
//  DetailRepository.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class DetailRepository: DetailRepositoryProtocol {
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager = ApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func getMovieDetail(movieId: Int) -> AnyPublisher<MovieDetail, ApiError> {
        return apiManager.request(.get, with: makeComponets(withEndpoint: "\(TheMovieDBAPI.detail)\(movieId)"), data: nil)
    }
    
    
}
