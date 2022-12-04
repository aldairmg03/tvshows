//
//  DetailRepositoryProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

protocol DetailRepositoryProtocol: AnyObject  {
    func getMovieDetail(movieId: Int) -> AnyPublisher<MovieDetail, ApiError>
}
