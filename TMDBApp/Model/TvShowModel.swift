//
//  TvShowModel.swift
//  TMDBApp
//
//  Created by Fatih on 11.04.2023.
//

import Foundation
struct TvShow: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
struct Result: Codable {
        var backdropPath, firstAirDate: String?
        var genreIDS: [Int]?
        var id: Int?
        var name: String?
        var originCountry: [String]?
        var originalLanguage, originalName, overview: String?
        var popularity: Double?
        var posterPath: String?
        var voteAverage: Double?
        var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name = "name"
    }
}
