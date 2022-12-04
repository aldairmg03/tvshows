//
//  ProfileCoordinator.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import UIKit
import Combine

class ProfileCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let builder = ProfileSceneBuilder()
        let viewController = builder.bind()
        self.navigationController.present(viewController, animated: true, completion: nil)
    }
    
    
}
