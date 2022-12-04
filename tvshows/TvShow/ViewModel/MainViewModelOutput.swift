//
//  MainViewModelOutput.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine

struct MainViewModelOutput {
    let showLoadingPublisher = PassthroughSubject<Void, Never>()
    let dismissLoadingPublisher = PassthroughSubject<Void, Never>()
    let tvShows = PassthroughSubject<[Movie], Never>()
}
