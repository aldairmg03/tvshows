//
//  DetailCoordinator.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import UIKit
import Combine

class DetailCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var subscriptions = Set<AnyCancellable>()
    private let movieId: Int
    
    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        let builder = DetailSceneBuilder()
        let viewController = builder.build(movieId: movieId)
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    
}
