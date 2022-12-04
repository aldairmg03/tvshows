//
//  MainViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine

final class MainViewModel: MainViewModelProtocol {
    
    let output = MainViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
 
    func bind(input: MainViewModelInput) -> MainViewModelOutput {
        
        input.fetchTvShowsPublisher.sink(receiveValue: { [weak self] index in
            self?.fetchTvShows(index: index)
        }).store(in: &subscriptions)
        
        return output
    }
    
    func fetchTvShows(index: Int) {
        self.output.showLoadingPublisher.send()
        let category = CategoryType.init(rawValue: index)?.category
        ApiManager.shared.tvShowFetch(forCategory: category!)
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
    
}