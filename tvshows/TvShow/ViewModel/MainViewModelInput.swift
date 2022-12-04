//
//  MainViewModelInput.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine
import UIKit

struct MainViewModelInput {
    let fetchTvShowsPublisher = PassthroughSubject<Int, Never>()
    let seeMovieDetailPublisher = PassthroughSubject<Int, Never>()
    let navigateToProfilePublisher = PassthroughSubject<Void, Never>()
    let navigateToLoginPublisher = PassthroughSubject<UISceneDelegate, Never>()
}
