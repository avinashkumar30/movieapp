//
//  MovieModel.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 09/05/22.
//

import Foundation

// MARK: - TitleModel
struct TitleModel: Codable {
    var title: String
    var model: [Result]
}

// MARK: - MovieData
struct MovieData: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let genreIDS: [Int]
//    let originalLanguage: OriginalLanguage
    let originalTitle: String?
    let posterPath: String
    let title: String?
    let id: Int
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let voteCount: Int
    let adult: Bool?
    let backdropPath: String
    let video: Bool?
    let popularity: Double
    let originalName: String?
    let originCountry: [String]?
    let firstAirDate, name: String?

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case title, id
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case video, popularity
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
        case name
    }
}
