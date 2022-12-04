//
//  MainUseCaseProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

protocol MainUseCaseProtocol: AnyObject {
    
    func tvShowFetch(forCategory category: String) -> AnyPublisher<TvShowsResponse, ApiError>
    
}
