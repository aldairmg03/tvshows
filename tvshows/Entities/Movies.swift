//
//  Movies.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

struct TvShowsResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let voteAverage: Double
    let overview: String
    let firstAirDate: String
    let originCountry: [String]
    let genreIDS: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}
