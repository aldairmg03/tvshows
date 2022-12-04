//
//  MainViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine
import UIKit

final class MainViewModel: MainViewModelProtocol {
    
    private let mainUseCase: MainUseCaseProtocol
    let output = MainViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
    
    init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
 
    func bind(input: MainViewModelInput) -> MainViewModelOutput {
        
        input.fetchTvShowsPublisher.sink(receiveValue: { [weak self] index in
            self?.fetchTvShows(index: index)
        }).store(in: &subscriptions)
        
        input.seeMovieDetailPublisher.sink(receiveValue: { [weak self] movieId in
            self?.navigateToMovieDetail(movieId: movieId)
        }).store(in: &subscriptions)
        
        input.navigateToProfilePublisher.sink { [weak self] in
            self?.navigateToMovieProfile()
        }.store(in: &subscriptions)
        
        input.closeSessionPublisher.sink {[weak self] sceneDelegate in
            self?.closeSession(with: sceneDelegate)
        }.store(in: &subscriptions)
        
        return output
    }
    
    func fetchTvShows(index: Int) {
        self.output.showLoadingPublisher.send()
        let category = CategoryType.init(rawValue: index)?.category
        self.mainUseCase.tvShowFetch(forCategory: category!)
            .map { response in
                response.results
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                self?.output.dismissLoadingPublisher.send()
            }, receiveValue: { [weak self] tvShows in
                self?.output.tvShows.send(tvShows)
            })
            .store(in: &subscriptions)
        
        
    }
    
    func navigateToMovieDetail(movieId: Int) {
        self.output.navigateToDetailPublisher.send(movieId)
    }
    
    func navigateToMovieProfile() {
        self.output.navigateToProfilePublisher.send()
    }
    
    func closeSession(with sceneDelegate: UISceneDelegate) {
        TvShowUserDefaults.shared.username = nil
        navigateToLogin(with: sceneDelegate)
    }
    
    func navigateToLogin(with sceneDelegate: UISceneDelegate) {
        self.output.navigateToLoginPublisher.send(sceneDelegate)
    }
    
}
