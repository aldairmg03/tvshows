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
    
    private func request<T>(
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

extension ApiManager {
    
    struct TheMovieDBAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3"
        static let key = "ff1541ffb94b89e3dc599b860dec920d"
        
        static let requesttoken = "/authentication/token/new"
        static let auth = "/authentication/token/validate_with_login"
    }
    
    enum RequestType: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private func makeComponets(withEndpoint endpoint: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = TheMovieDBAPI.scheme
        components.host = TheMovieDBAPI.host
        components.path = TheMovieDBAPI.path + "\(endpoint)"
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TheMovieDBAPI.key)
        ]
        
        return components
    }
    
}
