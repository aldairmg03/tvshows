//
//  MainViewModelInput.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine

struct MainViewModelInput {
    let fetchTvShowsPublisher = PassthroughSubject<Int, Never>()
}
