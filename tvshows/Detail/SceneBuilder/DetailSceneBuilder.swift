//
//  DetailSceneBuilder.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

class DetailSceneBuilder {
    
    func build(movieId: Int) -> DetailViewController {
        let repository = DetailRepository()
        let detailUserCase = DetailUseCase(repository: repository)
        let detailViewModel = DetailViewModel(detailUseCase: detailUserCase, movieId: movieId)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
    
}
