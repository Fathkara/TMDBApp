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
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let name: String?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let status, tagline, title: String?
    let episodeCount:String?
    let seasons: [Season]?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, homepage, id
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case status, tagline, title
        case name = "name"
        case episodeCount = "season_number"
        case seasons
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Season
struct Season: Codable {
    var airDate: String?
    var episodeCount, id: Int?
    var name, overview, posterPath: String?
    var seasonNumber: Int?
    enum CodingKeys: String, CodingKey {
        case seasonNumber = "season_number"
        case episodeCount = "episode_count"
    }
}
