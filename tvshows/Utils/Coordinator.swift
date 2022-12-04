//
//  Coordinator.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    func start()
    func coordinate(to coordinator: Coordinator)
}

public extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.start()
    }
}
