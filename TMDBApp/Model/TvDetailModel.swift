//
//  TvDetailModel.swift
//  TMDBApp
//
//  Created by Fatih on 14.04.2023.
//

import Foundation
import Foundation

// MARK: - Welcome
struct TvDetail: Codable {
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let name: String?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case name = "name"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
