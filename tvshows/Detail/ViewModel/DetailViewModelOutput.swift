//
//  DetailViewModelOutput.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

struct DetailViewModelOutput {
    let showLoadingPublisher = PassthroughSubject<Bool, Never>()
    let movieDetail = PassthroughSubject<MovieDetail, Never>()
}
