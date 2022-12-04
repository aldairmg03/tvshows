//
//  DetailViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

final class DetailViewModel: DetailViewModelProtocol {
    
    private let detailUseCase: DetailUseCaseProtocol
    let output = DetailViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
    private let movieId: Int
    
    init(detailUseCase: DetailUseCaseProtocol, movieId: Int) {
        self.detailUseCase = detailUseCase
        self.movieId = movieId
    }
    
    
    func bind(input: DetailViewModelInput) -> DetailViewModelOutput {
        
        input.getDetailPublisher.sink(receiveValue: { [weak self] in
            self?.fetchDetail()
        }).store(in: &subscriptions)
        
        return output
    }
    
    func fetchDetail() {
        self.output.showLoadingPublisher.send(true)
        self.detailUseCase.getMovieDetail(movieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                self?.output.showLoadingPublisher.send(false)
            }, receiveValue: { [weak self] response in
                self?.output.movieDetail.send(response)
            })
            .store(in: &subscriptions)
    }
    
    
}
