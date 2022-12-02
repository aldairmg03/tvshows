//
//  ApiManager.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import Combine

protocol ApiFetcheable {
    
    func tvShowFetch(forCategory category: String) -> AnyPublisher<TvShowsResponse, ApiError>
    
}

class ApiManager {
    
    public static let shared = ApiManager()
    
    private let session: URLSession
 
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ApiManager: ApiFetcheable {
    
    func tvShowFetch(forCategory category: String) -> AnyPublisher<TvShowsResponse, ApiError> {
        return forecast(with: makeComponets(withCategory: category))
    }
    
    private func forecast<T>(
      with components: URLComponents
    ) -> AnyPublisher<T, ApiError> where T: Decodable {
      guard let url = components.url else {
        let error = ApiError.network(description: "Couldn't create URL")
        return Fail(error: error).eraseToAnyPublisher()
      }
      return session.dataTaskPublisher(for: URLRequest(url: url))
        .mapError { error in
          .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
          decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
    
}

extension ApiManager {
    
    struct TheMovieDBAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3"
        static let key = "ff1541ffb94b89e3dc599b860dec920d"
    }
    
    private func makeComponets(withCategory category: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDBAPI.scheme
        components.host = TheMovieDBAPI.host
        components.path = TheMovieDBAPI.path + "\(category)"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDBAPI.key)
        ]
        
        return components
    }
    
}
