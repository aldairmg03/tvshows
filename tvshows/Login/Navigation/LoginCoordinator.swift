//
//  LoginCoordinator.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import UIKit
import Combine

class LoginCoodinator: Coordinator {
    var children: [Coordinator] = []
    
    var window: UIWindow
    private var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let builder = LoginSceneBuilder()
        let controller = builder.build()
        let output = controller.viewModel.output
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        output.navigateToMainPublisher.sink { [weak self] sceneDelegate in
            self?.coordinateToMain(with: sceneDelegate)
        }.store(in: &subscriptions)
        
    }
    
    private func coordinateToMain(with sceneDelegate: UISceneDelegate) {
        let sc = sceneDelegate as? SceneDelegate
        sc?.mainCoordinator?.start()
    }
    
    
}
