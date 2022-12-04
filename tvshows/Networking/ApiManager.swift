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
    
    func createRequestToken() -> AnyPublisher<CreateTokenResponse, ApiError>
    
    func authentication(auth: Authentication) -> AnyPublisher<CreateTokenResponse, ApiError>
    
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
        return request(.get, with: makeComponets(withEndpoint: category), data: nil)
    }
    
    func createRequestToken() -> AnyPublisher<CreateTokenResponse, ApiError> {
        return request(.get, with: makeComponets(withEndpoint: TheMovieDBAPI.requesttoken), data: nil)
    }
    
    func authentication(auth: Authentication) -> AnyPublisher<CreateTokenResponse, ApiError> {
        let jsonData = try? JSONEncoder().encode(auth)
        return request(.post, with: makeComponets(withEndpoint: TheMovieDBAPI.auth), data: jsonData)
    }
    
    func request<T>(
        _ type: RequestType,
        with components: URLComponents,
        data: Data?
    ) -> AnyPublisher<T, ApiError> where T: Decodable {
        guard let url = components.url else {
            let error = ApiError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = type.rawValue
        urlRequest.httpBody = data
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}
