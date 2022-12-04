//
//  MovieDetail.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

struct MovieDetail: Codable {
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let firstAirDate: String
    let genres: [Genre]
    let id: Int
    let name: String?
    let originalName: String
    let overview: String
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let voteAverage: Double
    let statusCode: Int?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case firstAirDate = "first_air_date"
        case genres
        case id
        case name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case voteAverage = "vote_average"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct CreatedBy: Codable {
    let id: Int
    let name: String
    let gender: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case profilePath = "profile_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
