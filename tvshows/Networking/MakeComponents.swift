//
//  MakeComponents.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

func makeComponets(withEndpoint endpoint: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = TheMovieDBAPI.scheme
    components.host = TheMovieDBAPI.host
    components.path = TheMovieDBAPI.path + "\(endpoint)"
    
    components.queryItems = [
        URLQueryItem(name: "api_key", value: TheMovieDBAPI.key)
    ]
    
    return components
}
