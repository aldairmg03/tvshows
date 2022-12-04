//
//  TheMovieDBAPI.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

struct TheMovieDBAPI {
    static let scheme = "https"
    static let host = "api.themoviedb.org"
    static let path = "/3"
    static let key = "ff1541ffb94b89e3dc599b860dec920d"
    
    static let requesttoken = "/authentication/token/new"
    static let auth = "/authentication/token/validate_with_login"
    static let detail = "/tv/"
}
