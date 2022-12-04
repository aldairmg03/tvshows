//
//  DetailUseCase.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

class DetailUseCase: DetailUseCaseProtocol {
    
    private let repository: DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovieDetail(movieId: Int) -> AnyPublisher<MovieDetail, ApiError> {
        return repository.getMovieDetail(movieId: movieId)
    }
    
}
