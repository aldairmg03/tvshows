//
//  MainCoordinator.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import UIKit
import Combine

class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var window: UIWindow
    private var navigationController: UINavigationController? = nil
    private var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let builder = MainSceneBuilder()
        let controller = builder.build()
        let output = controller.viewModel.output
        
        output.navigateToDetailPublisher.sink { [weak self] movieId in
            self?.coordinateToDetail(movieId: movieId)
        }.store(in: &subscriptions)
        
        output.navigateToProfilePublisher.sink { [weak self] movieId in
            self?.coordinateToProfile()
        }.store(in: &subscriptions)
        
        output.navigateToLoginPublisher.sink { [weak self] sceneDelegate in
            self?.coordinateToLogin(with: sceneDelegate)
        }.store(in: &subscriptions)
        
        navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    func coordinateToDetail(movieId: Int) {
        let detailCoordinator = DetailCoordinator(navigationController: self.navigationController!, movieId: movieId)
        coordinate(to: detailCoordinator)
    }
    
    func coordinateToProfile() {
        let detailCoordinator = ProfileCoordinator(navigationController: self.navigationController!)
        coordinate(to: detailCoordinator)
    }
    
    private func coordinateToLogin(with sceneDelegate: UISceneDelegate) {
        let sc = sceneDelegate as? SceneDelegate
        sc?.loginCoordinator?.start()
    }
    
    
}
